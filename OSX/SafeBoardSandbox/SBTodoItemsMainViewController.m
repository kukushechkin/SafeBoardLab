//
//  SBTodoItemsMainViewController.m
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import "SBTodoItemsMainViewController.h"

@interface SBTodoItemsMainViewController ()
    @property (nonatomic, strong) SBTodoManager * todoManager;
@end

@implementation SBTodoItemsMainViewController

- (void)awakeFromNib {
    self.todoManager = [SBTodoManager new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

@end
