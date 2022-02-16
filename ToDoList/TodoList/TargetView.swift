//
//  TaskView.swift
//  ToDoList
//
//  Created by user on 10.02.2022.
//

import SwiftUI

struct TargetView: View {
    let target: Target
    let onTapCompleted: () -> Void
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Rectangle()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.white)
                    .overlay(
                        Rectangle()
                            .stroke(.gray)
                    )
                    .onTapGesture(perform: onTapCompleted)

                if target.isComleted {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 12.5, height: 8.5)
                        .foregroundColor(.gray)
                        .font(.largeTitle.bold())
                        .padding(.leading, 7)
                }
                
            }
                
                .padding([.leading, .top], 16)
                .padding(.bottom, 13)
            
            Text(target.name ?? "")
                .padding(.top, 13)
                .padding(.bottom, 10)
                .font(.custom(.light, size: 15))
                .foregroundColor(target.isComleted ? .gray : .black)
            
        }
    }
}
