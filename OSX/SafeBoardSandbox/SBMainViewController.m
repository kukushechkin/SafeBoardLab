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
    
    [m_objectsArrayController addObserver:self
                               forKeyPath:@"arrangedObjects.statusColor"
                                  options:(NSKeyValueObservingOptionNew |
                                           NSKeyValueObservingOptionOld)
                                  context:NULL];
    // TODO: Do not forget to remove observer if objects is destroyed
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    [self willChangeValueForKey:@"isAnyObjectWorkingStatus"];
    [self didChangeValueForKey:@"isAnyObjectWorkingStatus"];
}

- (NSColor*)isAnyObjectWorkingStatus
{
    __block NSColor * retColor = [NSColor greenColor];
    [self.objectsArray enumerateObjectsUsingBlock:^(SBTheObject * yao, NSUInteger index, BOOL *stop) {
        if(yao.isWorkInProgress) {
            retColor = [NSColor redColor];
        }
    }];
    return retColor;
}

- (IBAction)removeAllObjects:(id)sender {
    // If no ARC:
    /*
    [self.objectsArray release];
     */
    
    self.objectsArray = [NSArray array];
}

// If no ARC:
/*
- (void)dealloc {
    [self.objectsArray release];
    [super dealloc];
}
*/

@end
