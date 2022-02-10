//
//  TaskView.swift
//  ToDoList
//
//  Created by user on 10.02.2022.
//

import SwiftUI

struct TaskView: View {
    let target: Target
    
    var body: some View {
        HStack {
            Rectangle()
//                .padding(.leading, 16)
//                .padding(.bottom, 13)
                .frame(width: 16, height: 16)
                .foregroundColor(.white)
                .overlay(
                    Rectangle()
                        .stroke(.gray)
                )
            
            Text("Example")
                .padding(.top, 13)
                .padding(.bottom, 10)
                .font(.custom("Poppins-Light", fixedSize: 15))
            
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static let target = Target()
    
    static var previews: some View {
        TaskView(target: target)
            .previewLayout(.sizeThatFits)
    }
}
