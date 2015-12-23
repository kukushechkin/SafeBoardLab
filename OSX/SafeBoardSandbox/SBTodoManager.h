//
//  SBTodoManager.h
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBTodoManager : NSObject
{
    NSArray * m_todoItems;
}

@property (nonatomic, readonly) NSArray * todoItems;

- (void)createObject;
- (void)removeObjectsAtIndex:(NSInteger)index;

@end
