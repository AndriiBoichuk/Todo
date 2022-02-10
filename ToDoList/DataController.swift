//
//  DataController.swift
//  ToDoList
//
//  Created by user on 10.02.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ToDoModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
