//
//  inputView.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 8/3/24.
//

import SwiftUI

struct inputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
                .font(.system(size: 16))
                .textCase(.lowercase)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .padding(10)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 42)
                    .background(.primary.opacity(0.05))
                    .cornerRadius(10)
                    .font(.system(size: 14))
            } else {
                TextField(placeholder, text: $text)
                    .padding(10)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 42)
                    .background(.primary.opacity(0.05))
                    .cornerRadius(10)
                    .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    inputView(text: .constant(""), title: "The email", placeholder: "name@example.com")
}
