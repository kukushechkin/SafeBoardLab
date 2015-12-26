//
//  SBTodoItemsMainViewController.m
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/23/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

#import "TodoMainViewController.h"

@implementation TodoMainViewController_objc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [m_itemsArrayController addObserver:self
                             forKeyPath:@"arrangedObjects.todoTitle"
                                options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                                context:NULL];
    [m_itemsArrayController addObserver:self
                             forKeyPath:@"arrangedObjects.todoDescription"
                                options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                                context:NULL];
    [m_itemsArrayController addObserver:self
                             forKeyPath:@"arrangedObjects.todoDueDate"
                                options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                                context:NULL];
    
    self.manager = [TodoManager new];
    [self.manager connect:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(NSArrayController*)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if(self.manager.items.count <= object.selectionIndex)
        return;
    
    TodoItem * selectedItem = [m_itemsArrayController.arrangedObjects objectAtIndex:object.selectionIndex];
    
    if([keyPath isEqualToString:@"arrangedObjects.todoTitle"]) {
        [self.manager updateTitleforObjectAtIndex:object.selectionIndex withValue:selectedItem.todoTitle];
    }
    if([keyPath isEqualToString:@"arrangedObjects.todoDescription"]) {
        [self.manager updateDescriptionforObjectAtIndex:object.selectionIndex withValue:selectedItem.todoDescription];
    }
    if([keyPath isEqualToString:@"arrangedObjects.todoDueDate"]) {
        [self.manager updateDueDateforObjectAtIndex:object.selectionIndex withValue:selectedItem.todoDueDate];
    }
}

- (IBAction)add:(id)sender {
    [self.manager createObject];
}

- (IBAction)remove:(id)sender {
    [self.manager removeObjectAtIndex:m_itemsArrayController.selectionIndex];
}

@end
