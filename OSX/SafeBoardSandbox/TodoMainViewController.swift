//
//  TodoMainViewController.swift
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/24/15.
//  Copyright © 2015 Kaspersky Lab. All rights reserved.
//

//
// Notice:
// To use this controller and _swift project, you should change class of Main View Controller object in MainMenu.xib
//

import Foundation
import Cocoa
import TodoManagerModel

class TodoMainViewController_swift : NSViewController {
    
    @IBOutlet var m_itemsArrayController : NSArrayController!
    
    @objc dynamic var manager: TodoManager {
        return TodoManager.shared()
    }
    
    override func viewDidLoad() {
        
        let options = NSKeyValueObservingOptions([.new, .old])
        
        m_itemsArrayController.addObserver(self, forKeyPath:"arrangedObjects.todoTitle", options:options, context:nil)
        m_itemsArrayController.addObserver(self, forKeyPath:"arrangedObjects.todoDescription", options:options, context:nil)
        m_itemsArrayController.addObserver(self, forKeyPath:"arrangedObjects.todoDueDate", options:options, context:nil)
        
        self.manager.connect(self);
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let arrayController = object as? NSArrayController {
            if(self.manager.items.count <= (arrayController as AnyObject).selectionIndex) {
                return;
            }
            
            if let selectedItem = (m_itemsArrayController.arrangedObjects as! NSArray).object(at:arrayController.selectionIndex) as? TodoItem {
                if(keyPath == "arrangedObjects.todoTitle") {
                    self.manager.updateTitleforObject(at: arrayController.selectionIndex, withValue:selectedItem.todoTitle)
                }
                if(keyPath == "arrangedObjects.todoDescription") {
                    self.manager.updateDescriptionforObject(at: arrayController.selectionIndex, withValue:selectedItem.todoDescription);
                }
                if(keyPath == "arrangedObjects.todoDueDate") {
                    self.manager.updateDueDateforObject(at: arrayController.selectionIndex, withValue:selectedItem.todoDueDate);
                }
            }
        }
    }
    
    @IBAction func add(_ sender: AnyObject?) {
        self.manager.createObject()
    }
    
    @IBAction func remove(_ sender: AnyObject?) {
        self.manager.removeObject(at: m_itemsArrayController.selectionIndex)
    }
}
