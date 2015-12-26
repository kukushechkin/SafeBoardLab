//
//  TodoItem.m
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/26/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import "TodoItem.h"
#import "todo_item.h"

@implementation TodoItem

- (instancetype)init {
    if(self = [super init]) {
        self.todoTitle = @"default title";
        self.todoDescription = @"default description";
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*)title
                           id:(NSInteger)newId
                      dueDate:(NSDate*)date
               andDescription:(NSString*)description {
    if(self = [super init]) {
        self.todoTitle = title;
        self.todoDescription = description;
        self.todoDueDate = date;
        self.todoId = newId;
    }
    return self;
}


@end
