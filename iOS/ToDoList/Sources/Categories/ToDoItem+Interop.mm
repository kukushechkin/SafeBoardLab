#import "ToDoItem+Interop.h"
#import "NSString+Interop.h"


@implementation ToDoItem (Interop)

- (instancetype)initWithToDoItemStruct:(const todo_sample::TodoItem &)todoItemStruct {
    return [self initWithIdentifier:[NSString stringWithToDoItemId:todoItemStruct.id]
                              title:[NSString stringWithUTF8String:todoItemStruct.title]
                               text:[NSString stringWithUTF8String:todoItemStruct.description]
                               date:[NSDate dateWithTimeIntervalSince1970:todoItemStruct.dueDateUtc]];
}

- (void)fillToDoItemStruct:(todo_sample::TodoItem &)todoItemStruct {
    if (self.identifier != nil) {
        todoItemStruct.id = [self.identifier todoItemId];
    }
    if (self.title != nil) {
        strncpy(todoItemStruct.title, [self.title UTF8String], sizeof(todoItemStruct.title));
    }
    if (self.text != nil) {
        strncpy(todoItemStruct.description, [self.text UTF8String], sizeof(todoItemStruct.description));
    }
    if (self.date != nil) {
        todoItemStruct.dueDateUtc = (std::time_t)[self.date timeIntervalSince1970];
    }
}

@end
