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
                      .foregroundColor(Color.backgrounCardDefault)
                      .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
              )
        }
    }
}

#Preview {
    LoaderView()
}
