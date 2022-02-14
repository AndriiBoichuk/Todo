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
                if enteredCode.count > 5 {
                    checkCode()
                }
            }
        }
        
        // Alert info
        @Published var alertTitle = ""
        @Published var alertMessage = ""
        @Published var isShowingAlert = false
        
        @Published var logStatus = false
        
        var code: String
        let phoneNumber: String
        
        init(_ code: String, _ phoneNumber: String) {
            self.code = code
            self.phoneNumber = phoneNumber
        }
        
        func resendCode() {
            clearField()
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { code, error in
                if let error = error {
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                    self.isShowingAlert.toggle()
                    return
                }
                self.code = code ?? ""
            }
        }
        
        func checkCode() {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: code, verificationCode: enteredCode)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                    self.isShowingAlert = true
                    return
                }
                
                self.logStatus = true
            }
        }
        
        func clearField() {
            withAnimation {
                enteredCode = ""
            }
        }
    }
}
