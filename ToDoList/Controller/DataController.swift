//
//  DataController.swift
//  ToDoList
//
//  Created by user on 10.02.2022.
//

import Foundation
import CoreData

class DataController: NSObject {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoModel")

        let appName: String = "ToDoList"
        var persistentStoreDescriptions: NSPersistentStoreDescription

        let group = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.dataContext")
        let storeUrl =  group!.appendingPathComponent("ToDoList.sqlite")


        let description = NSPersistentStoreDescription()
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        description.url = storeUrl

        container.persistentStoreDescriptions = [NSPersistentStoreDescription(url:  FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.dataContext")!.appendingPathComponent("ToDoList.sqlite"))]

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func getData() -> [Target] {
        let request = NSFetchRequest<Target>(entityName: "Target")
        
        do {
            let targets = try persistentContainer.viewContext.fetch(request)
            return targets
        } catch {
            print("Error getting data. \(error.localizedDescription)")
        }
        return []
    }
    
    func addData(text: String) {
        let target = Target(context: persistentContainer.viewContext)
        target.name = text
        target.isComleted = false
        
        saveData()
    }
    
    func saveData() {
        do {
            if persistentContainer.viewContext.hasChanges {
                try persistentContainer.viewContext.save()
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func updateData(_ target: Target) {
        persistentContainer.viewContext.performAndWait {
            target.isComleted.toggle()
            saveData()
        }
    }
    
    func removeData(_ target: Target) {
        persistentContainer.viewContext.delete(target)
        saveData()
    }
}
