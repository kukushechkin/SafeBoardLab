//
//  SBTodoManager.m
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import "SBTodoManager.h"
#import "SBTodoItem.hpp"
#import "todo_manager.h"

@interface SBTodoManager()
{
    todo_sample::TodoManager m_todoManager;
}

    @property (assign) BOOL isConnecting;
    @property (assign) BOOL isConnected;
@end

@implementation SBTodoManager

- (instancetype)init {
    if(self = [super init]) {
    }
    return self;
}

- (IBAction)connect:(id)sender {
    self.isConnecting = YES;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        if(m_todoManager.Connect()) {
           // TODO: Anything useful to do on connect?
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isConnecting = NO;
            self.isConnected = YES;
        });
    });
}

- (void)awakeFromNib {
    [m_itemsArrayController addObserver:self
                             forKeyPath:@"arrangedObjects.todoTitle"
                                options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                                context:NULL];
    [m_itemsArrayController addObserver:self
                             forKeyPath:@"arrangedObjects.todoDescription"
                                options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                                context:NULL];

}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(NSArrayController*)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    SBTodoItem * selectedItem = [m_todoItems objectAtIndex:[object selectionIndex]];
    auto rawItem = m_todoManager.GetItems()[[object selectionIndex]];
    
    if([keyPath isEqualToString:@"arrangedObjects.todoTitle"]) {
        strncpy(rawItem.title, std::string(256, '\0').c_str(), 256);
        strncpy(rawItem.title, [selectedItem.todoTitle UTF8String], selectedItem.todoTitle.length);
    }
    if([keyPath isEqualToString:@"arrangedObjects.todoDescription"]) {
        strncpy(rawItem.description, std::string(1024, '\0').c_str(), 1024);
        strncpy(rawItem.description, [selectedItem.todoDescription UTF8String], selectedItem.todoDescription.length);
    }
    
    [self willChangeValueForKey:@"isAnyObjectWorkingStatus"];
    m_todoManager.UpdateItem(rawItem);
    [self didChangeValueForKey:@"isAnyObjectWorkingStatus"];
}


- (NSArray*)todoItems {
    m_todoItems = [NSMutableArray array];
    for(const auto yai : m_todoManager.GetItems()) {
        [m_todoItems addObject:[[SBTodoItem alloc] initWithTitle:[NSString stringWithFormat:@"%s", yai.title]
                                                              id:yai.id
                                                         dueDate:[NSDate dateWithTimeIntervalSince1970:yai.dueDateUtc]
                                                  andDescription:[NSString stringWithFormat:@"%s", yai.description]]];
    }
    return m_todoItems;
}

- (void)createObject {
    [self willChangeValueForKey:@"todoItems"];
    m_todoManager.CreateItem();
    [self didChangeValueForKey:@"todoItems"];
}

- (void)removeObjectsAtIndex:(NSInteger)index {
    [self willChangeValueForKey:@"todoItems"];
    auto allItems = m_todoManager.GetItems();
    m_todoManager.DeleteItem(allItems[index].id);
    [self didChangeValueForKey:@"todoItems"];    
}

@end
