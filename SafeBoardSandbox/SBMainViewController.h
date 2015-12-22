//
//  SBMainViewController.h
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/22/15.
//  Copyright © 2015 Kaspersky Lab. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//<NSTableViewDelegate, NSTableViewDataSource>

@interface SBMainViewController : NSViewController
{
    IBOutlet NSArrayController * m_objectsArrayController;
}

@property (nonatomic, retain) NSArray * objectsArray;
@property (nonatomic, readonly) NSColor * isAnyObjectWorkingStatus;

- (IBAction)removeAllObjects:(id)sender;

@end
