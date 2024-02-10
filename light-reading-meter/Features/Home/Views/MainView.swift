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
           Text("Contenido de otra vista")
               .foregroundColor(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

