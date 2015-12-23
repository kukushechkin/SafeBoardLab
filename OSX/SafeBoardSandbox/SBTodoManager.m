//
//  SBTodoManager.m
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import "SBTodoManager.h"

@implementation SBTodoManager

- (instancetype)init {
    if(self = [super init]) {
        self.todoItems = [NSArray new];
    }
    return self;
}

@end
