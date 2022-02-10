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
            let task = Target(context: viewContext)
            task.name = data
            task.isComleted = false
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
    }
}
