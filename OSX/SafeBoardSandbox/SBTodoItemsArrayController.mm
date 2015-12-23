//
//  SBTodoItemsArrayController.m
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import "SBTodoItemsArrayController.h"

@implementation SBTodoItemsArrayController

//- (void)awakeFromNib {
//}

- (IBAction)add:(id)sender {
    [m_manager createObject];
}

- (IBAction)remove:(id)sender {
    [m_manager removeObjectsAtIndex:self.selectionIndex];
}

@end
