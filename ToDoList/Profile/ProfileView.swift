//
//  ProfileView.swift
//  ToDoList
//
//  Created by user on 17.02.2022.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentation
    let phoneNumber: String
    @AppStorage("logStatus") var logStatus = false
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .foregroundColor(.black.opacity(0.5))
                        
                        Spacer()
                    }
                    HStack {
                        Text("Phone number")
                        
                        Spacer()
                        
                        Text(phoneNumber)
                            .fontWeight(.medium)
                    }
                    .font(.custom(.light, size: 18))
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Button {
                            logStatus = false
                            appState.rootViewId = UUID()
                        } label: {
                            Text("Log out")
                                .font(.custom(.regular, size: 18)
                                )
                                .foregroundColor(.red)
                        }
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(phoneNumber: "+380983474145")
    }
}
