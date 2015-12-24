#import "ToDoItem.h"
#import "ToDoManagerDelegate.h"


@interface ToDoManager : NSObject

@property (nonatomic, weak) id<ToDoManagerDelegate> delegate;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (BOOL)connect;
- (void)asyncConnectWithCompletionHandler:(void (^)(BOOL success))completionHandler;
- (void)disconnect;

- (NSArray<id<ToDoItem>> *)items;
- (void)addItem:(id<ToDoItem>)item;

@end
