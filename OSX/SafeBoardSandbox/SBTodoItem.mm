//
//  SBTodoItem.m
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import "SBTodoItem.hpp"

@implementation SBTodoItem

- (instancetype)init {
    if(self = [super init]) {
        self.todoTitle = @"default title";
        self.todoDescription = @"default description";
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*)title dueDate:(NSDate*)date andDescription:(NSString*)description {
    if(self = [super init]) {
        self.todoTitle = title;
        self.todoDescription = description;
        self.todoDueDate = date;
    }
    return self;
}

@end
