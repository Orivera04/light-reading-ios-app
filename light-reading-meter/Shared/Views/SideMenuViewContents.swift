//
//  SideViewContents.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 9/2/24.
//

import SwiftUI

struct SideMenuViewContents: View {
    @Binding var presentSideMenu: Bool
       
    var body: some View {
        ZStack {
            VStack {
                Text("Menu")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
                    .padding(.top, 50)
            }
            .frame( maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(.white)
    }
}

