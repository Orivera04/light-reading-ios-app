//
//  LoaderView.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 15/2/24.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
              Color.black.opacity(0.4)
                  .edgesIgnoringSafeArea(.all)
              
              VStack {
                  ProgressView()
                      .progressViewStyle(CircularProgressViewStyle(tint: .textColorSecondary))
                      .scaleEffect(2)
                  
                  Text("loading")
                      .foregroundColor(.textColorSecondary)
                      .font(.headline)
                      .padding(.top, 20)
              }
              .padding(50)
              .background(
                  RoundedRectangle(cornerRadius: 16)
                      .foregroundColor(Color.backgrounCardDefault.opacity(0.8))
              )
        }
    }
}

#Preview {
    LoaderView()
}
