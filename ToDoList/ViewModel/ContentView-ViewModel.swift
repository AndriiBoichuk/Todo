//
//  ContentView-ViewModel.swift
//  ToDoList
//
//  Created by user on 10.02.2022.
//

import Foundation
import CoreData

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        let viewContext: NSManagedObjectContext
        
        @Published var targets: [Target] = []
        
        init() {
            let dataController = DataController()
            viewContext = dataController.container.viewContext
            getData()
        }
        
        func getData() {
            let request = NSFetchRequest<Target>(entityName: "Target") //exact name as in the CoreData file
            
            do {
                try targets = viewContext.fetch(request)
            } catch {
                print("Error getting data. \(error.localizedDescription)")
            }
        }
        
        func addData(_ data: String) {
            let target = Target(context: viewContext)
            target.name = data
            target.isComleted = false
            
            saveData()
        }
        
        func saveData() {
            do {
                if viewContext.hasChanges {
                    try viewContext.save()
                    getData()
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        func updateData(_ target: Target) {
            viewContext.performAndWait {
                target.isComleted.toggle()
                saveData()
            }
        }
        
        func removeData(_ indexSet: IndexSet) {
            for index in indexSet {
                viewContext.delete(targets[index])
            }
            saveData()
        }
    }
}
