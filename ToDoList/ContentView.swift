//
//  ContentView.swift
//  ToDoList
//
//  Created by user on 10.02.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.targets) { target in
                    Text("Example")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Do later stuff")
                        .padding()
                        .font(.custom("Poppins-Light", fixedSize: 17))
                }
            }
        }
//        .background(Color("backgroundColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
