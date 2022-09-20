//
//  MainView.swift
//  ToDoList
//
//  Created by user on 17.02.2022.
//

import SwiftUI

struct MainView: View {
    @AppStorage("logStatus") var logStatus = false
    @AppStorage("phoneNumber") var phoneNumber = ""
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        if logStatus == true {
            TodoListView(phoneNumber)
        } else {
            LoginView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
