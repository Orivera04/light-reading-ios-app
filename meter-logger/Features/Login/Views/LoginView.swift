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
         ZStack {
             BackGroundElementsView()

             VStack (alignment: .leading) {
                 VStack {
                     Text("hellow".capitalized)
                         .foregroundStyle(.primary)
                         .font(Font.system(size: 90))
                         .bold()

                     Text("sign_in_to_your_account".capitalized)
                         .foregroundStyle(.primary)
                         .font(.title2)
                 }
                 .padding(.top, 140)

                 Spacer()

                 VStack(spacing: 24) {
                     inputView(text: $authViewModel.user.email,
                               title: "email",
                               placeholder: "")

                     inputView(text: $authViewModel.user.password,
                               title: "password",
                               placeholder: "",
                               isSecureField: true)

                     ButtonView(text: "sign_in",
                                disabled: authViewModel.formIsValid,
                                width: UIScreen.main.bounds.width / 2,
                                trigger: { authViewModel.login() })
                                .padding(.top, 28)

                     NavigationLink(destination: CreateUserView().navigationBarBackButtonHidden(true)) {
                         HStack {
                             Text("dont_have_an_account?")
                             Text("create")
                                 .bold()
                         }
                     }
                     .padding(.top, 114)
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

 #Preview {
     LoginView()
 }
