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
            VStack(alignment: .leading, spacing: 0) {
                SideMenuTopView()
                VStack {
                    Text("Menu")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .padding(.top, 50)
                    
                    NavigationLink(destination: Text("Mis medidores")) {
                       HStack {
                           Image(systemName: "speedometer")
                               .foregroundColor(.white)
                               .font(.headline)
                           Text("Mis medidores")
                               .foregroundColor(.white)
                               .font(.headline)
                       }
                       .padding(.vertical, 10)
                       .padding(.horizontal, 20)
                       .background(Color.blue)
                       .cornerRadius(10)
                    }
                    
                }.frame( maxWidth: .infinity, maxHeight: .infinity)
           }
           .frame(maxWidth: .infinity)
           .background(.white)
       }
    }
       
    func SideMenuTopView() -> some View {
        VStack {
            HStack {
                Button(action: {
                    presentSideMenu.toggle()
                }, 
                label: {
                    Image(systemName: "x.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
               })
               .frame(width: 34, height: 34)
               Spacer()
           }
       }
       .frame(maxWidth: .infinity)
       .padding(.leading, 40)
       .padding(.top, 40)
       .padding(.bottom, 30)
   }
}
