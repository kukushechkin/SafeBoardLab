#import "NSString+Interop.h"


@implementation NSString (Interop)

+ (NSString *)stringWithToDoItemId:(todo_sample::TodoItemId)itemId {
    return [@(itemId) description];
}

- (todo_sample::TodoItemId)todoItemId {
    return (todo_sample::TodoItemId)[self intValue];
}

@end
