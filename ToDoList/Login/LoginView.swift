//
//  LoginView.swift
//  ToDoList
//
//  Created by user on 11.02.2022.
//

import SwiftUI
import iPhoneNumberField

struct LoginView: View {
    enum FocusField: Hashable {
        case field
    }
    
    @StateObject var viewModel = ViewModel()
    
    @FocusState var isShowingKeyboard: FocusField?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .rotationEffect(.radians(.pi/4))
                        .foregroundColor(.black)
                        .background(
                            Circle()
                                .frame(width: 44, height: 44)
                                .tint(Color("backgroundColor"))
                            
                        )
                }
                Spacer()
            }
            .padding(.leading, 17)
            
            Text("Enter your phone number")
                .font(.custom("Poppins-SemiBold", fixedSize: 24))
                .padding(.top, 46)
            
            Text("We will send you confirmation code")
                .font(.custom("Poppins-Regular", fixedSize: 15))
                .padding(.top)
            
            TextField("(00) 0000-000-000", text: $viewModel.phoneNumber)
                .padding(.horizontal)
                .frame(height: 68)
                .font(.custom("Poppins-Regular", size: 24))
                .background(Color("backgroundColor").opacity(0.3))
                .cornerRadius(10)
                .keyboardType(.numberPad)
                .focused($isShowingKeyboard, equals: .field)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.isShowingKeyboard = .field
                    }
                }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.right")
                        .font(.title2)
                        .foregroundColor(Color("limeColor"))
                        .background(
                            Circle()
                                .frame(width: 64, height: 64)
                                .tint(Color("buttonColor"))
                        )
                        .padding(32)
                }
                .disabled(!viewModel.isNumberEntered())
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 48)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
