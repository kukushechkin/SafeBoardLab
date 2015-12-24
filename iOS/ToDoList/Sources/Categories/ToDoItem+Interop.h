#import "ToDoItem.h"
#include <todo/todo_item.h>


@interface ToDoItem (Interop)

- (instancetype)initWithToDoItemStruct:(const todo_sample::TodoItem &)todoItemStruct;

- (void)fillToDoItemStruct:(todo_sample::TodoItem &)todoItemStruct;

@end
