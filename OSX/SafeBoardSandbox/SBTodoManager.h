//
//  SBTodoManager.h
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "todo_manager.h"

@interface SBTodoManager : NSObject
{
    todo_sample::TodoManager m_todoManager;
}

@property (nonatomic, retain) NSArray * todoItems;

@end
