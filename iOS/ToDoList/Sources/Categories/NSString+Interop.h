#import <Foundation/Foundation.h>
#include <todo/todo_item.h>


@interface NSString (Interop)

+ (NSString *)stringWithToDoItemId:(todo_sample::TodoItemId)itemId;
- (todo_sample::TodoItemId)todoItemId;

@end
