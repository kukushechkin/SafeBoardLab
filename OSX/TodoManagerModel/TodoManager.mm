//
//  TodoManager.m
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/26/15.
//  Copyright © 2015 Kaspersky Lab. All rights reserved.
//

#import "TodoManager.h"
#import "todo_manager.h"

class ConnectCallback : public todo_sample::IConnectCallback
{
public:

    virtual void OnConnect(bool success) override
    {
        if (m_handler)
            m_handler(success);
    }
    
    void (^m_handler)(bool) = 0;
};


@interface TodoManager()
{
    todo_sample::TodoManager m_todoManager;
    ConnectCallback          m_connectCallback;
}
    @property (assign) BOOL isConnecting;
    @property (assign) BOOL isConnected;
@end

@implementation TodoManager

+ (instancetype)sharedManager
{
    static TodoManager* _sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [TodoManager new];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSArray*)items {
    m_items = [NSMutableArray array];
    for(const auto yai : m_todoManager.GetItems()) {
        [m_items addObject:[[TodoItem alloc] initWithTitle:[NSString stringWithFormat:@"%s", yai.title]
                                                        id:yai.id
                                                   dueDate:[NSDate dateWithTimeIntervalSince1970:yai.dueDateUtc]
                                            andDescription:[NSString stringWithFormat:@"%s", yai.description]]];
    }
    return m_items;
}

- (IBAction)connect:(id)sender {

    self.isConnecting = YES;

    m_connectCallback.m_handler = ^(bool success){
        self.isConnecting = NO;
        self.isConnected = success;
    };
    
    m_todoManager.Connect(&m_connectCallback);
}

- (IBAction)disconnect:(id)sender {
    m_todoManager.Close();
    self.isConnected = NO;
}

- (void)createObject {
    [self willChangeValueForKey:@"items"];
    m_todoManager.CreateItem();
    [self didChangeValueForKey:@"items"];
}

- (void)removeObjectAtIndex:(NSInteger)index {
    auto allItems = m_todoManager.GetItems();

    [self willChangeValueForKey:@"items"];
    m_todoManager.DeleteItem(allItems[index].id);
    [self didChangeValueForKey:@"items"];
}

- (void)updateTitleforObjectAtIndex:(NSInteger)index withValue:(NSString*)newValue {
    todo_sample::TodoItem rawItem;
    m_todoManager.GetItem(self.items[index].todoId, rawItem);
    strncpy(rawItem.title, std::string(256, '\0').c_str(), 256);
    strncpy(rawItem.title, [newValue UTF8String], newValue.length);
    
    m_todoManager.UpdateItem(rawItem);
}

- (void)updateDescriptionforObjectAtIndex:(NSInteger)index withValue:(NSString*)newValue {
    todo_sample::TodoItem rawItem;
    m_todoManager.GetItem(self.items[index].todoId, rawItem);
    strncpy(rawItem.description, std::string(1024, '\0').c_str(), 1024);
    strncpy(rawItem.description, [newValue UTF8String], newValue.length);
    
    m_todoManager.UpdateItem(rawItem);
}

- (void)updateDueDateforObjectAtIndex:(NSInteger)index withValue:(NSDate*)newValue {
    todo_sample::TodoItem rawItem;
    m_todoManager.GetItem(self.items[index].todoId, rawItem);
    rawItem.dueDateUtc = [newValue timeIntervalSince1970];
    
    m_todoManager.UpdateItem(rawItem);
}

@end
