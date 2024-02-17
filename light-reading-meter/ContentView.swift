//
//  ContentView.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 16/2/24.
//

import SwiftUI

struct ContentView: View {
    @State var presentSideMenu = false

    var body: some View {
       NavbarView(presentSideMenu: $presentSideMenu) {
           NavigationStack {
               HomeView()
           }
       }
    }
}

#Preview {
    ContentView()
}
