//
//  ContentView.swift
//  ToDoList
//
//  Created by user on 10.02.2022.
//

import SwiftUI

struct TodoListView: View {
    enum FocusField: Hashable {
        case field
    }
    
    @StateObject private var viewModel: ViewModel
    
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        ZStack {
            List {
                Section {
                    ForEach(viewModel.targets.filter { $0.isComleted == false }, id: \.name) { target in
                        TargetView(target: target) {
                            withAnimation {
                                viewModel.updateData(target)
                            }
                        }
                        
                    }
                    .onDelete { indexSet in
                        viewModel.removeData(indexSet)
                    }
                }
                Section {
                    ForEach(viewModel.targets.filter { $0.isComleted }, id: \.name) { target in
                        TargetView(target: target) {
                            withAnimation {
                                viewModel.updateData(target)
                            }
                        }
                        
                    }
                    .onDelete { indexSet in
                        viewModel.removeData(indexSet)
                    }
                } header: {
                    Text("Completed")
                        .font(.custom(.light, size: 12))
                        .foregroundColor(.black)
                }
                .opacity(viewModel.targets.filter { $0.isComleted }.count == 0 ? 0 : 1)
            }.listStyle(InsetGroupedListStyle())
            
            VStack {
                Spacer()
                TextField("What do you like to do", text: $viewModel.textEntered)
                    .padding(.horizontal)
                    .focused($focusedField, equals: .field)
                    .frame(height: 44
                    )
                    .background(.white)
                    .opacity(viewModel.isKeyboardShowing ? 1 : 0)
                    .submitLabel(.done)
                    .onSubmit {
                        viewModel.isKeyboardShowing = false
                        viewModel.addData()
                    }
                if !viewModel.isKeyboardShowing {
                    HStack {
                        Spacer()
                        
                        Button {
                            viewModel.isKeyboardShowing = true
                            focusedField = .field
                        } label: {
                            Image(systemName: "plus")
                                .font(.title.bold())
                        }
                        .padding()
                        .background(Color.buttonColor)
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding()
                    }
                }
            }
            
            SideMenu(phoneNumber: viewModel.phoneNumber, isOpen: viewModel.isShowingProfile, menuClose: showProfile)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.isShowingProfile ? "" : "Do later stuff")
                    .padding()
                    .font(.custom(.light, size: 17))
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showProfile()
                } label: {
                    Text("Profile")
                        .padding()
                        .foregroundColor(.black)
                        .font(.custom(.light, size: 17))
                }
            }
        }
    }
    
    func showProfile() {
        viewModel.isShowingProfile.toggle()
    }
    
    init(_ phoneNumber: String) {
        self._viewModel = StateObject(wrappedValue: ViewModel(phoneNumber))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView("+380983474145")
    }
}
