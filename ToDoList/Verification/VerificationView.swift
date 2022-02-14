//
//  VerificationView.swift
//  ToDoList
//
//  Created by user on 11.02.2022.
//

import SwiftUI

struct VerificationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack: some View {
        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
            HStack {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
        }
    }
    
    enum FocusField: Hashable {
        case field
    }
    
    @StateObject var viewModel: ViewModel
    
    @FocusState var isShowingKeyboard: FocusField?
    
    var body: some View {
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
                                    .tint(Color("backgroundColor"))
                                
                            )
                    }
                    Spacer()
                }
                .padding(.leading, 17)
                
                Text("Phone Verification")
                    .font(.custom("Poppins-SemiBold", fixedSize: 24))
                    .padding(.top, 46)
                
                Text("Please enter the 6-digit code sent to you at \(viewModel.phoneNumber)")
                    .font(.custom("Poppins-Light", fixedSize: 18))
                    .padding(.top)
                
                Button {
                    viewModel.resendCode()
                } label: {
                    Text("Resend code")
                }
                .padding(.vertical)
                .font(.custom("Poppins-SemiBold", fixedSize: 15))
                .foregroundColor(.black)
                
                NavigationLink(destination: TodoListView(), isActive: $viewModel.logStatus) {
                    Text("")
                        .hidden()
                }
                
                TextField("000000", text: $viewModel.enteredCode)
                    .padding(.horizontal)
                    .frame(height: 68)
                    .font(.custom("Poppins-Regular", size: 24))
                    .background(Color("backgroundColor").opacity(0.3))
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .focused($isShowingKeyboard, equals: .field)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.isShowingKeyboard = .field
                        }
                    }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
            
            if viewModel.isShowingAlert {
                CustomAlertView(alertTitle: viewModel.alertTitle, alertMessage: viewModel.alertMessage, isShowingAlert: $viewModel.isShowingAlert)
            }
        }
    }
    
    init(_ phoneNumber: String, _ code: String) {
        self._viewModel = StateObject(wrappedValue: ViewModel(code, phoneNumber))
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VerificationView("+380983474145", "433566")
        }
    }
}
