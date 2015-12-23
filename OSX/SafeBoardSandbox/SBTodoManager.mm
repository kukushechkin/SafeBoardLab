//
//  SBTodoManager.m
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import "SBTodoManager.h"
#import "SBTodoItem.h"
#import "todo_manager.h"

@interface SBTodoManager()
{
    todo_sample::TodoManager m_todoManager;
}
@end

@implementation SBTodoManager

- (instancetype)init {
    if(self = [super init]) {
    }
    return self;
}

- (NSArray*)todoItems {
    NSMutableArray * ret = [NSMutableArray array];
    for(const auto yai : m_todoManager.GetItems()) {
        [ret addObject:[[SBTodoItem alloc] initWithTitle:[NSString stringWithFormat:@"%s", yai.title] andDescription:[NSString stringWithFormat:@"%s", yai.description]]];
    }
    return ret;
}

- (void)createObject {
    [self willChangeValueForKey:@"todoItems"];
    m_todoManager.CreateItem();
    [self didChangeValueForKey:@"todoItems"];
}

- (void)removeObjectsAtIndex:(NSInteger)index {
    [self willChangeValueForKey:@"todoItems"];
    auto allItems = m_todoManager.GetItems();
    m_todoManager.DeleteItem(allItems[index].id);
    [self didChangeValueForKey:@"todoItems"];    
}

@end
