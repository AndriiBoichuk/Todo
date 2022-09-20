//
//  SideMenu.swift
//  ToDoList
//
//  Created by user on 18.02.2022.
//

import SwiftUI

struct SideMenu: View {
    let phoneNumber: String
    let isOpen: Bool
    let menuClose: () -> Void
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.menuClose()
            }
            
            HStack {
                ProfileView(phoneNumber: phoneNumber)
                    .frame(width: 300)
                    .background(Color.white)
                    .offset(x: self.isOpen ? 0 : -300)
                    .animation(.default)
                
                Spacer()
            }
        }
    }
}
