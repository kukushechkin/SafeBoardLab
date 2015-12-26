//
//  SBTodoItemsMainViewController.h
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <TodoManagerModel/TodoManagerModel.h>

@interface TodoMainViewController_objc : NSViewController
{
    IBOutlet NSArrayController * m_itemsArrayController;
}

@property (nonatomic, retain) TodoManager * manager;

- (IBAction)add:(id)sender;
- (IBAction)remove:(id)sender;

@end
