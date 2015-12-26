//
//  SBTodoItem.h
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "todo_item.h"

@interface SBTodoItem : NSObject
{
}

@property (assign) todo_sample::TodoItemId todoId;
@property (retain) NSString * todoTitle;
@property (retain) NSString * todoDescription;
@property (retain) NSDate * todoDueDate;

- (instancetype)initWithTitle:(NSString*)title id:(todo_sample::TodoItemId)newId dueDate:(NSDate*)date andDescription:(NSString*)description;

@end
