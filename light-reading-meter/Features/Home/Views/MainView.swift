//
//  ContentView.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 6/2/24.
//

import SwiftUI

struct MainView: View {
    @State var presentSideMenu = false

    var body: some View {
        NavbarView(presentSideMenu: $presentSideMenu) {
            VStack {
                HStack {
                    Spacer()
                    Button(action: { print("Button tapped!") }) {
                        Text("Registrar medidor")
                            .padding(15)
                            .foregroundColor(Color.text)
                    }
                    .background(
                        RadialGradient(gradient: Gradient(colors: [Color.buttonMain, Color.buttonSecondary]), center: .center, startRadius: 1, endRadius: 100)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                NavigationStack {
                    List {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.icon)
                            Text("Medidor de Oscar")
                        }
                        .frame(height: 60)
                        HStack {
                            Image(systemName: "pencil")
                                .foregroundColor(.icon)
                            Text("Medidor de Johana")
                        }
                        .frame(height: 60)
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.primaryBackground)
                    .navigationTitle("Mis medidores")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
