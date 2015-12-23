//
//  SBTheObject.h
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/22/15.
//  Copyright © 2015 Kaspersky Lab. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface SBTheObject : NSObject
{
    NSColor * m_statusColor;
}

@property (assign) long theValue;
@property (retain) NSString * theName;
@property (readonly) BOOL isWorkInProgress;

@property (readonly) NSColor * statusColor;

- (void)doWork;

@end
