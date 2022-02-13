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
        @Published var errorMessage = ""
        @Published var isShowingMessage = false
        
        @Published var code = "" {
            didSet {
                goToVerification = true
            }
        }
        
        @Published var goToVerification = false
        
        init() {
            logStatus = false
            phoneNumber.append(countryModel.getPhoneCode())
            
            // Change language code to french.
            Auth.auth().languageCode = "ua";
        }
        
        func isNumberEntered() -> Bool {
//            return phoneNumber.count == 13 ? true : false
            return true
        }
        
        func sendCode() {
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { code, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.isShowingMessage.toggle()
                    return
                }
                self.code = code ?? ""
                self.goToVerification = true
            }
        }
        
        func clearField() {
            phoneNumber = ""
        }
        
        func checkPossibilityTransition() {
            if isNumberEntered() {
                sendCode()
//                goToVerification = true
            }
        }
    }
}
