//
//  SBTodoItemsMainViewController.h
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SBTodoManager.h"

@interface SBTodoItemsMainViewController : NSViewController
{
}

@property (readonly, strong) SBTodoManager * todoManager;

@end
