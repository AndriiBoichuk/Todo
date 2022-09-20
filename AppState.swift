//
//  AppState.swift
//  ToDoList
//
//  Created by user on 17.02.2022.
//

import Foundation

final class AppState : ObservableObject {
    @Published var rootViewId = UUID()
}
