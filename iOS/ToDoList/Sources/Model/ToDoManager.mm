#import "ToDoManager.h"
#import "ToDoItem+Interop.h"
#include <todo/todo_manager.h>


@interface ToDoManager () {
    todo_sample::TodoManager _todoManager;
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

#pragma mark - Public

- (BOOL)connect {
    return _todoManager.Connect();
}

- (void)asyncConnectWithCompletionHandler:(void (^)(BOOL success))completionHandler {
    ToDoManager * __weak weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL success = [weakSelf connect];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionHandler != nil) {
                completionHandler(success);
            }
        });
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
    strcpy(itemStruct.title, [item.title UTF8String]);
    strcpy(itemStruct.description, [item.text UTF8String]);
    itemStruct.dueDateUtc = (std::time_t)[item.date timeIntervalSince1970];
    _todoManager.UpdateItem(itemStruct);
}

@end
