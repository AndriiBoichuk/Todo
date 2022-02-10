//
//  ContentView.swift
//  ToDoList
//
//  Created by user on 10.02.2022.
//

import SwiftUI

struct ContentView: View {
    enum FocusField: Hashable {
        case field
    }
    
    @StateObject private var viewModel = ViewModel()
    
    @FocusState private var focusedField: FocusField?
    
    @State private var isKeyboardShowing = false
    @State private var textEntered = ""
    
    var body: some View {
        NavigationView {
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
                            .font(.custom("Poppins-Light", fixedSize: 12))
                            .foregroundColor(.black)
                    }
                    .opacity(viewModel.targets.filter { $0.isComleted }.count == 0 ? 0 : 1)
                }.listStyle(InsetGroupedListStyle())
                
                VStack {
                    Spacer()
                    TextField("What do you like to do", text: $textEntered)
                        .padding(.horizontal)
                        .focused($focusedField, equals: .field)
                        .frame(height: 44
                        )
                        .background(.white)
                        .opacity(isKeyboardShowing ? 1 : 0)
                        .submitLabel(.done)
                        .onSubmit {
                            isKeyboardShowing = false
                            viewModel.addData(textEntered)
                            textEntered = ""
                        }
                    if !isKeyboardShowing {
                        HStack {
                            Spacer()
                            
                            Button {
                                isKeyboardShowing = true
                                focusedField = .field
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title.bold())
                            }
                            .padding()
                            .background(Color("buttonColor"))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding()
                        }
                    }
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
