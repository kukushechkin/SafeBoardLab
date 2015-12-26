//
//  TodoItem.h
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/26/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoItem : NSObject
{
}

@property (assign) NSInteger todoId;
@property (retain) NSString * todoTitle;
@property (retain) NSString * todoDescription;
@property (retain) NSDate * todoDueDate;

- (instancetype)initWithTitle:(NSString*)title
                           id:(NSInteger)newId
                      dueDate:(NSDate*)date
               andDescription:(NSString*)description;

@end
