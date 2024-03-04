//
//  LoginView.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 23/2/24.
//

import SwiftUI

 struct LoginView: View {
     @State private var email: String = ""
     @State private var password: String = ""
     @EnvironmentObject var authViewModel: AuthViewModel
     
     var body: some View {
         GeometryReader { geometry in
             ZStack {
                 VStack {
                     Image("navbar-icon")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 150, height: 150)
                         .padding(.top, 40)

                     Spacer()

                     Rectangle()
                         .fill(.white)
                         .clipShape(
                             .rect(
                                 topTrailingRadius: 160
                             ))
                         .frame(maxWidth: .infinity, maxHeight: .infinity)
                 }
                 .ignoresSafeArea()
                
                 VStack{
                     Spacer()
                         .frame(height: 140)

                     VStack {
                         Text("hellow")
                             .font(Font.system(size: 90))
                             .bold()
                             .padding(.leading, 20)
                             .frame(width: geometry.size.width, alignment: .leading)

                         Text("sign_in_to_your_account")
                             .font(.title2)
                             .padding(.leading, 20)
                             .frame(width: geometry.size.width, alignment: .leading)
                     }
                     .padding([.bottom], 60)

                     VStack {
                         VStack {
                             Text("email")
                                 .font(.title2)
                                 .fontWeight(.semibold)
                                 .padding(.leading, 20)
                                 .frame(width: geometry.size.width, alignment: .leading)

                             TextField("", text: $authViewModel.user.email)
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

                             TextField("", text: $authViewModel.user.password)
                                 .padding()
                                 .frame(width: 350, height: 60)
                                 .background(Color.black.opacity(0.05))
                                 .cornerRadius(10)
                         }
                         .padding(.bottom, 40)

                         Button("sign_in") {
                             Task {
                                 // TODO: make async
                                 authViewModel.login()
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
                         
                         NavigationLink(destination: CreateUserView().navigationBarBackButtonHidden(true)) {
                             HStack {
                                 Text("dont_have_an_account?")
                                 Text("create")
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
     LoginView()
 }
