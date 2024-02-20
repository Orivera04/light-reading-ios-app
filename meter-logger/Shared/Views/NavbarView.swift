//
//  Navbar.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 9/2/24.
//

import SwiftUI

struct NavbarView<Content: View>: View {
    @Binding var presentSideMenu: Bool
    var content: () -> Content

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                content()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top, 70)
            .padding(.horizontal, 5)
            .background(Color.primaryBackground)
            .overlay(
                ZStack {
                    HStack {
                        Button {
                            presentSideMenu.toggle()
                        } label: {
                            Image("burger-menu")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(width: 25, height: 25)
                        .padding(.leading, 20)
                        Spacer()
                        Image("navbar-icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                            .padding(.trailing, 20)
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(
                    RadialGradient(gradient: Gradient(colors: [Color.navbarColorPrimary, Color.navbarColorSecondary]), center: .center, startRadius: 1, endRadius: 200)
                )
                .zIndex(1)
                .shadow(radius: 0.3)
                , alignment: .top)
            .background(Color.white.opacity(0.8))

            SideMenu()
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func SideMenu() -> some View {
        SideMenuView(isShowing: $presentSideMenu, direction: .leading) {
            SideMenuViewContents(presentSideMenu: $presentSideMenu)
                .frame(width: 300)
        }
    }
}
