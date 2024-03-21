//
//  ButtonView.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 15/3/24.
//

import SwiftUI

struct ButtonView: View {
    let text: String
    let disabled: Bool
    let width: CGFloat
    let trigger: () -> Void
    
    
    var body: some View {
        VStack {
            Button(NSLocalizedString(text, comment: "input \(text)").capitalized) {
                trigger()
            }
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: width, height: 48)
            .background(
                RadialGradient(
                    gradient: Gradient(colors: [Color.navbarColorPrimary, Color.navbarColorSecondary]),
                    center: .center,
                    startRadius: 1,
                    endRadius: 50
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .disabled(!disabled)
            .opacity(disabled ? 1.0 : 0.5)
        }
    }
}

#Preview {
    ButtonView(text: "for testing",
               disabled: true,
               width: UIScreen.main.bounds.width / 2,
               trigger: { print("Eto es una prueba") })
}
