//
//  VerificationViewModel.swift
//  ToDoList
//
//  Created by user on 11.02.2022.
//

import Foundation
import Firebase
import SwiftUI

extension VerificationView {
    @MainActor class ViewModel: ObservableObject {
        @Published var enteredCode = "" {
            didSet {
                checkCode()
            }
        }
        
        // Alert info
        @Published var errorMessage = ""
        @Published var isShowingMessage = false
        
        @AppStorage("logStatus") var logStatus = false
        
        var code: String
        let phoneNumber: String
        
        init(_ code: String, _ phoneNumber: String) {
            logStatus = false
            self.code = code
            self.phoneNumber = phoneNumber
        }
        
        func resendCode() {
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { code, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.isShowingMessage.toggle()
                    return
                }
                self.code = code ?? ""
            }
        }
        
        func checkCode() {
            if enteredCode.count > 5 {
                print(code)
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: code, verificationCode: enteredCode)
                
                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        self.isShowingMessage = true
                        return
                    }
                    
                    self.logStatus = true
                }
            }
        }
        
        func clearField() {
            enteredCode = ""
        }
    }
}
