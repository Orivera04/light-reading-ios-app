//
//  CreateUserView.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 23/2/24.
//


import SwiftUI
import PhotosUI

struct CreateUserView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    @State private var shouldShowImagePicker = false
    @State private var image:UIImage?

    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var data: Data?

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()

                    Rectangle()
                        .fill(.white)
                        .clipShape(
                            .rect(
                                topTrailingRadius: 160
                            ))
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height - 30)
                        .ignoresSafeArea()
                }
                .ignoresSafeArea()

                VStack{
                    Spacer()
                        .frame(height: 140)

                    VStack {
                        VStack {
                            if let data = data, let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 128, height: 128)
                                    .cornerRadius(64)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 64))
                                    .padding()
                                    .foregroundColor(Color(.label))
                            }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 64).stroke(Color.black, lineWidth: 3))

                        PhotosPicker(
                            selection: $selectedItems,
                            maxSelectionCount: 1,
                            matching: .images
                        ) {
                            Text("Pick Photo")
                        }
                        .onChange(of: selectedItems) { newValue in
                            guard let item = selectedItems.first else {
                                return
                            }

                            item.loadTransferable(type: Data.self) { result in
                                switch result {
                                case .success(let data):
                                    if let data = data {
                                        self.data = data
                                    } else {
                                        print("Data is Nil")
                                    }
                                case .failure(let failure):
                                    fatalError("\(failure)")
                                }
                            }
                        }
                    }

                    VStack {
                        VStack {
                            Text("name")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.leading, 20)
                                .frame(width: geometry.size.width, alignment: .leading)

                            TextField("", text: $name)
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

                            TextField("", text: $email)
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

                            SecureField("", text: $password)
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

                            SecureField("", text: $repeatPassword)
                                .padding()
                                .frame(width: 350, height: 60)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)

                                Button("create") {
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
