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
    
    @IBOutlet var m_itemsArrayController: ArrayController!
    @objc dynamic let manager = TodoManager.shared()!
    
    override func viewDidLoad() {
        self.manager.connect(self);
    }
    
    @IBAction func add(_ sender: AnyObject?) {
        self.manager.createObject()
    }
    
    @IBAction func remove(_ sender: AnyObject?) {
        self.manager.removeObject(at: m_itemsArrayController.selectionIndex)
    }
}
