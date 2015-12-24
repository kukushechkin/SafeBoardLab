#import <Foundation/Foundation.h>

@class ToDoManager;
@protocol ToDoItem;


@protocol ToDoManagerDelegate <NSObject>
@optional

- (void)todoManager:(ToDoManager *)todoManager didAddItem:(id<ToDoItem>)item;
- (void)todoManager:(ToDoManager *)todoManager didUpdateItem:(id<ToDoItem>)item;
- (void)todoManager:(ToDoManager *)todoManager didDeleteItemWithIdentifier:(NSString *)identifier;

@end
