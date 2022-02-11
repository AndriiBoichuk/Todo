//
//  LoginViewModel.swift
//  ToDoList
//
//  Created by user on 11.02.2022.
//

import Foundation

extension LoginView {
    @MainActor class ViewModel: ObservableObject {
        let countryModel = CountryModel()
        
        @Published var phoneNumber = ""
        
//        private let mask = "+XX XXX XXX XX XX"
        
        init() {
            phoneNumber.append(countryModel.getPhoneCode())
        }
        
        func isNumberEntered() -> Bool {
            phoneNumber.count == 12 ? true : false
        }
        
//        func getCountryCode() -> String {
//            let regionCode = Locale.current.regionCode
//        }
        
    }
}
