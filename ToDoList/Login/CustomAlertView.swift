//
//  CustomAlertView.swift
//  ToDoList
//
//  Created by user on 14.02.2022.
//

import SwiftUI

struct CustomAlertView: View {
    let alertTitle: String
    let alertMessage: String
    @Binding var isShowingAlert: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text(alertTitle)
                .font(.custom(.regular, size: 24))
                .foregroundColor(.gray)
                .padding(.top)
            Text(alertMessage)
                .font(.custom(.light, size: 14))
                .padding(10)
            Spacer()
            Button {
                withAnimation {
                    isShowingAlert.toggle()
                }
            } label: {
                Text("Ok")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(.yellow)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .shadow(radius: 3)
                    .padding()
            }

        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 260)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(alertTitle: "Error", alertMessage: "Some description about error", isShowingAlert: .constant(true))
    }
}
