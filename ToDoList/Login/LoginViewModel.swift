//
//  LoginViewModel.swift
//  ToDoList
//
//  Created by user on 11.02.2022.
//

import Foundation
import Firebase
import SwiftUI

extension LoginView {
    @MainActor class ViewModel: ObservableObject {
        private let countryModel = CountryModel()
        private let characterLimit = 12
        
        @Published var phoneNumber = "+"
        @AppStorage("logStatus") var logStatus = false
        
        // Alert info
        @Published var alertMessage = ""
        @Published var isShowingAlert = false
        @Published var alertTitle = ""
        
        
        @Published var code = "" {
            didSet {
                goToVerification = true
            }
        }
        
        @Published var goToVerification = false
        
        init() {
            logStatus = false
            phoneNumber.append(countryModel.getPhoneCode())
        }
        
        func isNumberEntered() -> Bool {
            return phoneNumber.count == 13 ? true : false
        }
        
        func sendCode() {
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { code, error in
                if let error = error {
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                    self.isShowingAlert.toggle()
                    return
                }
                self.code = code ?? ""
                self.goToVerification = true
            }
        }
        
        func isValidPhone() -> Bool {
            let phoneRegex = "^\\+380[4569][0-9]{8}"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phoneNumber)
        }
        
        func clearField() {
            phoneNumber = ""
        }
        
        func checkPossibilityTransition() {
            if isNumberEntered() {
                if isValidPhone() {
                    sendCode()
                } else {
                    alertTitle = "Invalid number"
                    alertMessage = "Invalid number entered"
                    withAnimation {
                        isShowingAlert = true
                    }
                }
            } else {
                alertTitle = "Number not entered"
                alertMessage = "Number must be 13 characters"
                withAnimation {
                    isShowingAlert = true
                }
            }
        }
    }
}
