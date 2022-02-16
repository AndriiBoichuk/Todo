//
//  LoginView.swift
//  ToDoList
//
//  Created by user on 11.02.2022.
//

import SwiftUI

struct LoginView: View {
    enum FocusField: Hashable {
        case field
    }
    enum LoadingState {
        case none, loading
    }
    
    @State private var stateLoading: LoadingState = .none
    
    @StateObject var viewModel = ViewModel()
    
    @FocusState var isShowingKeyboard: FocusField?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Button {
                            viewModel.clearField()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title2)
                                .rotationEffect(.radians(.pi/4))
                                .foregroundColor(.black)
                                .background(
                                    Circle()
                                        .frame(width: 44, height: 44)
                                        .tint(.backgroundColor)
                                    
                                )
                        }
                        Spacer()
                    }
                    .padding(.leading, 17)
                    
                    Text("Enter your phone number")
                        .font(.custom(.semiBold, size: 24))
                        .padding(.top, 46)
                    
                    Text("We will send you confirmation code")
                        .font(.custom(.regular, size: 15))
                        .padding(.top)
                    
                    TextField("(00) 0000-000-000", text: $viewModel.phoneNumber)
                        .padding(.horizontal)
                        .frame(height: 68)
                        .font(.custom(.regular, size: 24))
                        .background(Color.backgroundColor.opacity(0.3))
                        .cornerRadius(10)
                        
                        .keyboardType(.numberPad)
                        .focused($isShowingKeyboard, equals: .field)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.isShowingKeyboard = .field
                            }
                        }
                    
                    Spacer()
                    
                    NavigationLink(destination: VerificationView(viewModel.phoneNumber, viewModel.code), isActive: $viewModel.goToVerification) {
                        Text("")
                            .hidden()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            viewModel.checkPossibilityTransition()
                        } label: {
                            Image(systemName: "arrow.right")
                                .font(.title2)
                                .foregroundColor(.limeColor)
                                .background(
                                    Circle()
                                        .frame(width: 64, height: 64)
                                        .tint(.buttonColor)
                                )
                                .padding(32)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .navigationBarTitleDisplayMode(.inline)
                
                if viewModel.isShowingAlert {
                    CustomAlertView(alertTitle: viewModel.alertTitle, alertMessage: viewModel.alertMessage, isShowingAlert: $viewModel.isShowingAlert)
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
