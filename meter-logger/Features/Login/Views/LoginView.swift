//
//  LoginView.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 23/2/24.
//

import SwiftUI

 struct LoginView: View {
     @State private var userName = ""
     @State private var password = ""

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
                         .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height - 100)
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

                             TextField("", text: $userName)
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

                             TextField("", text: $password)
                                 .padding()
                                 .frame(width: 350, height: 60)
                                 .background(Color.black.opacity(0.05))
                                 .cornerRadius(10)

                             Button("forgot_your_password?") {
                              // TODO: Redirect to forgot your password page.
                             }
                             .padding(.trailing, 20)
                             .frame(width: geometry.size.width, alignment: .trailing)
                         }
                         .padding(.bottom, 40)

                         Button("sign_in") {
                          // TODO: Validate Login
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

                         HStack {
                             Text("dont_have_an_account?")
                             Button("create") {

                             }
                             .fontWeight(.semibold)
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
