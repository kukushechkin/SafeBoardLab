//
//  SBTheObject.m
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/22/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import "SBTheObject.h"

@implementation SBTheObject

@synthesize isWorkInProgress = m_isWorkInProgress;

- (instancetype)init {
    if(self = [super init]) {
        self.theName = @"new object";
    }
    return self;
}

- (void)doWork {
    [self willChangeValueForKey:@"isWorkInProgress"];
    m_isWorkInProgress = YES;
    [self didChangeValueForKey:@"isWorkInProgress"];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        while(self.theValue--) {
            long tmp = 2 * self.theValue;
            NSLog(@"%d", self.theValue);
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"Work is done");
            [self willChangeValueForKey:@"isWorkInProgress"];
            m_isWorkInProgress = NO;
            [self didChangeValueForKey:@"isWorkInProgress"];
        });
    });
}

@end
