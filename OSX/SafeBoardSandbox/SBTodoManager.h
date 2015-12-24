//
//  SBTodoManager.h
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface SBTodoManager : NSObject
{
    NSMutableArray * m_todoItems;
    IBOutlet NSArrayController * m_itemsArrayController;
}

@property (nonatomic, readonly) NSArray * todoItems;
@property (nonatomic, readonly) BOOL isConnected;
@property (nonatomic, readonly) BOOL isConnecting;

- (void)createObject;
- (void)removeObjectsAtIndex:(NSInteger)index;

- (IBAction)connect:(id)sender;

@end
