//
//  SBTheObject.h
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/22/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBTheObject : NSObject
{
    BOOL m_isWorkInProgress;
}

@property (assign) long theValue;
@property (retain) NSString * theName;
@property (readonly) BOOL isWorkInProgress;

- (void)doWork;

@end
