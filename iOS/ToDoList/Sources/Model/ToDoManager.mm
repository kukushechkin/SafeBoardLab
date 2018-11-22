#import "ToDoManager.h"
#import "ToDoItem+Interop.h"
#include <todo/todo_manager.h>

class ConnectCallback : public todo_sample::IConnectCallback {
public:
    
    void OnConnect(bool success) {
        if (m_handler) {
            m_handler(success);
        }
    }
    
    void (^m_handler)(bool) = 0;
};

@interface ToDoManager () {
    todo_sample::TodoManager _todoManager;
    ConnectCallback _connectCallback;
}

@end

@implementation ToDoManager

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        // TODO: set callbacks
    }
    return self;
}

- (void)dealloc {
    [self disconnect];
}

#pragma mark - Private

- (void)connectWithBlock:(void (^)(BOOL success))completionHandler {
    
    _connectCallback.m_handler = ^(bool success){
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(success);
        });
    };
    
    _todoManager.Connect(&_connectCallback);
}

#pragma mark - Public

- (void)asyncConnectWithCompletionHandler:(void (^)(BOOL success))completionHandler {
    ToDoManager * __weak weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf connectWithBlock:completionHandler];
    });
}

- (void)disconnect {
    _todoManager.Close();
}

- (NSArray<id<ToDoItem>> *)items {
    NSMutableArray<id<ToDoItem>> *results = [NSMutableArray new];
    
    todo_sample::TodoItemsCollection collection = _todoManager.GetItems();
    for (todo_sample::TodoItemsCollection::const_iterator it = collection.begin(); it != collection.end(); ++it) {
        ToDoItem *item = [[ToDoItem alloc] initWithToDoItemStruct:*it];
        [results addObject:item];
    }
    
    return [results copy];
}

- (void)addItem:(id<ToDoItem>)item {
    todo_sample::TodoItem itemStruct = _todoManager.CreateItem();
    [(ToDoItem *)item fillToDoItemStruct:itemStruct];
    _todoManager.UpdateItem(itemStruct);
}

@end
