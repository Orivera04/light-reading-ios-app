//
//  NewReadingView.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 13/2/24.
//

import SwiftUI

struct NewReadingView: View {
    @State private var reading: Int = 0
    @State private var newCycle: Bool = false
    @State private var date: Date = Date()


    var body: some View {
        VStack {
            HStack {
                Text("reading")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding()
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                NavigationLink(destination: CreateMeterView()) {
                    Text("open_camera")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .foregroundColor(Color.textColorPrimary)
                }
                .background(
                    RadialGradient(gradient: Gradient(colors: [Color.buttonMain, Color.buttonSecondary]), center: .center, startRadius: 1, endRadius: 100)
                )
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .padding(.horizontal, 15)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            HStack {
                Form {
                    Section(header: Text("fill_data")) {
                        HStack {
                            Image(systemName: "bolt")
                                .foregroundColor(Color.icon)
                            TextField("reading", value: $reading, formatter: NumberFormatter())
                            Text("KWH")
                        }
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.icon)
                            DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
                                Text("select_date")
                            }
                        }
                    }

                    Section(header: Text("new_billing_cycle")) {
                        Toggle("save_new_billing_cycle", isOn: $newCycle)
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        print("_")
                    }) {
                        Label("edit", systemImage: "pencil")
                    }
                    Button(action: {
                        print("_")
                    }) {
                        Label("delete", systemImage: "trash")
                    }
                }
                label: {
                    Label("actions", systemImage: "ellipsis.circle")
                }
            }
        }
    }
}

#Preview {
    NewReadingView()
}
