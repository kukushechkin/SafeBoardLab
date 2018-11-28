//
//  ArrayController.swift
//  SafeBoardSandbox
//
//  Created by Anthony Ilinykh on 28/11/2018.
//  Copyright © 2018 Vladimir Kukushkin. All rights reserved.
//

import Cocoa
import TodoManagerModel

class ArrayController: NSArrayController {
    
    override func objectDidEndEditing(_ editor: NSEditor) {
        
        guard
            let array = arrangedObjects as? NSArray,
            let item = array.object(at: selectionIndex) as? TodoItem,
            let manager = TodoManager.shared()
            else { return }
        
        manager.updateTitleforObject(at: selectionIndex, withValue: item.todoTitle)
        manager.updateDescriptionforObject(at: selectionIndex, withValue: item.todoDescription)
        manager.updateDueDateforObject(at: selectionIndex, withValue: item.todoDueDate)
    }

}
