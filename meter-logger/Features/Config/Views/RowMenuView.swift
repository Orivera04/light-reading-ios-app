//
//  RowMenuView.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 2/4/24.
//

import SwiftUI

struct RowMenuView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.primary)
        }
    }
}

#Preview {
    RowMenuView(imageName: "gear", title: "Telegram", tintColor: Color(.systemGray))
}
