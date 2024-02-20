//
//  MeterCardView.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 14/2/24.
//

import SwiftUI

struct MeterCardView: View {
    let title: String
    let icon: String
    let value: String

    var body: some View {
          VStack(alignment: .leading, spacing: 0) {
              HStack {
                  Text(title)
                      .font(.system(size: 15))
                      .fontWeight(.semibold)
                      .foregroundColor(.primary)
                      .padding(.leading, 12)
                  Spacer()
                  Image(systemName: icon)
                      .imageScale(.medium)
                      .foregroundColor(.blue)
                      .padding(12)
              }
              Text(value)
                  .font(.callout)
                  .foregroundColor(.gray)
                  .padding(.horizontal, 12)
          }
          .frame(height: 130)
          .background(Color.backgrounCardDefault)
          .cornerRadius(16)
          .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}
