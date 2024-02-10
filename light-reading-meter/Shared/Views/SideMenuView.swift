//
//  SideMenu.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 9/2/24.
//

import SwiftUI

struct SideMenuView<RenderView: View>: View {
    @Binding var isShowing: Bool
       var direction: Edge
       @ViewBuilder  var content: RenderView
       
       var body: some View {
           ZStack(alignment: .leading) {
               if isShowing {
                   Color.black
                       .opacity(0.3)
                       .ignoresSafeArea()
                       .onTapGesture {
                           isShowing.toggle()
                       }
                   content
                       .transition(.move(edge: direction))
                       .background(
                           Color.white
                       )
               }
           }
           .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
           .ignoresSafeArea()
           .animation(.easeInOut, value: isShowing)
       }
}
