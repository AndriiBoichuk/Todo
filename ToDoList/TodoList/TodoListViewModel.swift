//
//  TodoListViewModel.swift
//  ToDoList
//
//  Created by user on 10.02.2022.
//

import SwiftUI
import CoreData

extension TodoListView {    
    @MainActor class ViewModel: ObservableObject {
        let dataController = DataController()
        
        @Published var targets: [Target] = []
        
        @Published var isKeyboardShowing = false
        @Published var textEntered = ""
        
        @Published var isShowingProfile = false
        
        let phoneNumber: String
        
        init(_ phoneNumber: String) {
            self.phoneNumber = phoneNumber
            getData()
        }
        
        func getData() {
            targets = dataController.getData()
            print(Thread.current)
        }
        
        func addData() {
            dataController.addData(text: textEntered)
            textEntered = ""
            getData()
        }
        
        func updateData(_ target: Target) {
            dataController.updateData(target)
            getData()
        }
        
        func removeData(_ indexSet: IndexSet) {
            for index in indexSet {
                dataController.removeData(targets[index])
            }
            getData()
        }
    }
}
