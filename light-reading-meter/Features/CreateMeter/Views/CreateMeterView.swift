//
//  CreateMeterView.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 12/2/24.
//

import SwiftUI

struct CreateMeterView: View {
    @State private var name: String = ""
    @State private var tag: String = ""
    @State private var monthlyConsumption: Int = 100

    var body: some View {
        VStack {
            HStack {
                Text("meter")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding()
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Form {
                    Section(header: Text("basic_data")) {
                        HStack {
                            Image(systemName: "gauge")
                                .foregroundColor(Color.icon)
                            TextField("name", text: $name)
                        }
                        HStack {
                            Image(systemName: "tag")
                                .foregroundColor(.icon)
                            TextField("tag", text: $tag)
                        }
                    }

                    Section(header: Text("maximum_consumption")) {
                        Stepper("\(monthlyConsumption) KWH", value: $monthlyConsumption, in: 0...1000)
                    }
                }
            }
            Button(action: { print("_") }) {
                Text("save")
                    .padding(.horizontal, 45)
                    .padding(.vertical, 15)
                    .foregroundColor(.white)
            }
            .background(
                RadialGradient(gradient: Gradient(colors: [Color.buttonMain, Color.buttonSecondary]), center: .center, startRadius: 1, endRadius: 100)
            )
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.primaryBackground)
    }
}

#Preview {
    CreateMeterView()
}
