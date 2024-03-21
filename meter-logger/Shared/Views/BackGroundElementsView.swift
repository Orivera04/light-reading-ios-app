//
//  BackGroundElementsView.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 14/3/24.
//

import SwiftUI

struct BackGroundElementsView: View {
    var body: some View {
        VStack {
            Image("navbar-icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding(.top, 40)
            
            Spacer()
            
            Rectangle()
                .fill(.primaryBackground)
                .clipShape(
                    .rect(
                        topTrailingRadius: 160
                    ))
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity)
                .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackGroundElementsView()
}
