
//
//  ContentView.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 16/2/24.
//

import SwiftUI

struct ContentView: View {
    @State var presentSideMenu = false
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
            if true {
                LoginView()
            } else {
            NavbarView(presentSideMenu: $presentSideMenu) {
                NavigationStack {
                    HomeView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
