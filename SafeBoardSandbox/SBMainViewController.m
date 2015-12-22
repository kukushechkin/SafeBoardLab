//
//  SBMainViewController.m
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/22/15.
//  Copyright © 2015 Kaspersky Lab. All rights reserved.
//

#import "SBMainViewController.h"
#import "SBTheObject.h"

@implementation SBMainViewController

- (void)awakeFromNib {
    self.objectsArray = [NSArray array];
    
    // If no ARC:
    /*
    self.objectsArray = [[NSArray alloc] init];  // or new
     */
}

// If no ARC:
/*
- (void)dealloc {
    [self.objectsArray release];
    [super dealloc];
}
*/

@end
