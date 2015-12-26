//
//  SBTodoItemsArrayController.swift
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/24/15.
//  Copyright © 2015 Vladimir Kukushkin. All rights reserved.
//

import Foundation
import Cocoa
import TodoManagerModel

class TodoMainViewController_swift : NSViewController {
    var manager = TodoManager()
    @IBOutlet var m_itemsArrayController : NSArrayController!
    
    override func viewDidLoad() {
        
        let options = NSKeyValueObservingOptions([.New, .Old])
        
        m_itemsArrayController.addObserver(self, forKeyPath:"arrangedObjects.todoTitle", options:options, context:nil)
        m_itemsArrayController.addObserver(self, forKeyPath:"arrangedObjects.todoDescription", options:options, context:nil)
        m_itemsArrayController.addObserver(self, forKeyPath:"arrangedObjects.todoDueDate", options:options, context:nil)
        
        self.manager.connect(self);
    }
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let arrayController = object {
            if(self.manager.items.count <= arrayController.selectionIndex) {
                return;
            }
            
            let selectedItem = m_itemsArrayController.arrangedObjects.objectAtIndex(arrayController.selectionIndex)
            if(keyPath == "arrangedObjects.todoTitle") {
                self.manager.updateTitleforObjectAtIndex(arrayController.selectionIndex, withValue:selectedItem.todoTitle)
            }
            if(keyPath == "arrangedObjects.todoDescription") {
                self.manager.updateDescriptionforObjectAtIndex(arrayController.selectionIndex, withValue:selectedItem.todoDescription);
            }
            if(keyPath == "arrangedObjects.todoDueDate") {
                self.manager.updateDueDateforObjectAtIndex(arrayController.selectionIndex, withValue:selectedItem.todoDueDate);
            }
        }
    }
    
    @IBAction func add(sender: AnyObject?) {
        self.manager.createObject()
    }
    
    @IBAction func remove(sender: AnyObject?) {
        self.manager.removeObjectAtIndex(m_itemsArrayController.selectionIndex)
    }
}