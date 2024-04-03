//
//  ConfigView.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 2/4/24.
//

import SwiftUI

struct ConfigView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
        
    var body: some View {
        List {
            Section {
                Button {
                    print("To Edit profil")
                } label: {
                    HStack {
                        Text(authViewModel.user.name.prefix(1).uppercased())
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                            .frame(width: 72, height: 72)
                            .background(.primary.opacity(0.05))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(authViewModel.user.name)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(authViewModel.user.email)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Section("General") {
                HStack {
                    Button {
                        print("To telegram configuration")
                    } label: {
                        RowMenuView(imageName: "gear", 
                                    title: "Telegram",
                                    tintColor: Color(.green))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            Section("Account") {
                HStack {
                    Button {
                        print("Sing Out . . . ")
                        authViewModel.logOut()
                    } label: {
                        RowMenuView(imageName: "arrow.left.circle.fill",
                                    title: "Sing Out",
                                    tintColor: Color(.red))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

#Preview {
    ConfigView()
}
