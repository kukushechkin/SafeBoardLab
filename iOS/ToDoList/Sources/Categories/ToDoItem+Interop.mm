#import "ToDoItem+Interop.h"
#import "NSString+Interop.h"


@implementation ToDoItem (Interop)

- (instancetype)initWithToDoItemStruct:(const todo_sample::TodoItem &)todoItemStruct {
    return [self initWithIdentifier:[NSString stringWithToDoItemId:todoItemStruct.id]
                              title:[NSString stringWithUTF8String:todoItemStruct.title]
                               text:[NSString stringWithUTF8String:todoItemStruct.description]
                               date:[NSDate dateWithTimeIntervalSince1970:todoItemStruct.dueDateUtc]];
}

@end
