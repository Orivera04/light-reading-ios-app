//
//  CreateUserView.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 23/2/24.
//


import SwiftUI
import PhotosUI

struct CreateUserView: View {
    @StateObject private var viewModel: CreateUserViewModel
       
    init() {
        _viewModel = StateObject(wrappedValue: CreateUserViewModel())
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                        .frame(height: 200)
                    
                    Rectangle()
                        .fill(.white)
                        .clipShape(
                            .rect(
                                topTrailingRadius: 160
                            ))
                        .frame(maxWidth: geometry.size.width, maxHeight: .infinity)
                        .ignoresSafeArea()
                }
                .ignoresSafeArea()
                

                VStack{
                    // Only for testing
                    Spacer()
                        .frame(height: 80)

                    VStack {
                        VStack {
                            Text("name")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.leading, 20)
                                .frame(width: geometry.size.width, alignment: .leading)

                            TextField("", text: $viewModel.user.name)
                                .padding()
                                .frame(width: 350, height: 60)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)

                        VStack {
                            Text("email")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.leading, 20)
                                .frame(width: geometry.size.width, alignment: .leading)

                            TextField("", text: $viewModel.user.email)
                                .padding()
                                .frame(width: 350, height: 60)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)

                        VStack {
                            Text("password")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.leading, 20)
                                .frame(width: geometry.size.width, alignment: .leading)

                            SecureField("", text: $viewModel.user.password)
                                .padding()
                                .frame(width: 350, height: 60)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)

                        VStack {
                            Text("repeat_your_password")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.leading, 20)
                                .frame(width: geometry.size.width, alignment: .leading)

                            //SecureField("", text: $repeatPassword)
                                //  .padding()
                                //.frame(width: 350, height: 60)
                                // .background(Color.black.opacity(0.05))
                                // .cornerRadius(10)
                        }
                        .padding(.bottom, 20)

                                Button("create") {
                                    Task {
                                        // TODO: make async this function.
                                        viewModel.createUser()
                                    }
                                }
                                .font(.title3)
                                .bold()
                                .padding()
                                .foregroundColor(.white)
                                .background(
                                    RadialGradient(
                                        gradient: Gradient(colors: [Color.navbarColorPrimary, Color.navbarColorSecondary]),
                                        center: .center,
                                        startRadius: 1,
                                        endRadius: 50
                                    )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.bottom, 30)
                        
                                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                                    HStack {
                                        Text("you_have_an_account?")
                                        Text("sign_in")
                                            .bold()
                                    }
                                }
                            }
                        }
                    }
                    .background(
                        RadialGradient(
                            gradient: Gradient(colors: [Color.navbarColorPrimary, Color.navbarColorSecondary]),
                            center: .center,
                            startRadius: 1,
                            endRadius: 200
                        )
                    )
                }
            }
        }

#Preview {
    CreateUserView()
}
