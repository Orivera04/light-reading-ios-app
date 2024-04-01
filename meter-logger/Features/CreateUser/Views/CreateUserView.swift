//
//  CreateUserView.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 23/2/24.
//


import SwiftUI

struct CreateUserView: View {
    @StateObject private var viewModel: CreateUserViewModel
    @State private var redirectToHome: Bool = false

    init() {
        _viewModel = StateObject(wrappedValue: CreateUserViewModel())
    }

    var body: some View {
        ZStack {
            BackGroundElementsView()

            VStack(alignment: .leading){
                Spacer()

                Text("create_user")
                    .foregroundStyle(.primary)
                    .font(.title2)
                    .padding(.bottom, 24)

                VStack(spacing: 24) {
                    inputView(text: $viewModel.user.name,
                              title: "name",
                              placeholder: "")

                    inputView(text: $viewModel.user.email,
                              title: "email",
                              placeholder: "")

                    inputView(text: $viewModel.user.password,
                              title: "password",
                              placeholder: "",
                              isSecureField: true)

                    inputView(text: $viewModel.repeat_password,
                              title: "repeat_your_password",
                              placeholder: "",
                              isSecureField: true)

                    ButtonView(text: "create",
                               disabled: viewModel.formIsValid,
                               width: UIScreen.main.bounds.width / 2,
                               trigger: { viewModel.createUser() })
                               .padding(.top, 28)

                    NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                        HStack {
                            Text("you_have_an_account?")
                            Text("sign_in")
                                .bold()
                        }
                    }
                    .padding(.top, 48)
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
        .alert(isPresented: $viewModel.showMessage) {
            Alert(
               title: Text(viewModel.messageTitle),
               message: Text(viewModel.messageBody),
               dismissButton: .default(Text("ok")) {
                   redirectToHome = viewModel.isSuccess
               }
           )
        }
        .navigationDestination(isPresented: $redirectToHome) {
            HomeView().navigationBarBackButtonHidden(true)
        }
        .overlay {
            if viewModel.isLoading {
                LoaderView()
            }
        }
    }
}

#Preview {
    CreateUserView()
}
