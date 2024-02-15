//
//  MeterView.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 13/2/24.
//

import SwiftUI

struct MeterView: View {
    var body: some View {
        GeometryReader{ geometry in
            VStack {
                VStack{
                    MeterWidgetView()
                }
                VStack {
                    HStack {
                        MeterCardView(title: NSLocalizedString("last_billing_period", comment: ""), icon: "clock", value: "10/11/1997")
                            .frame(width: geometry.size.width * 0.31)
                        MeterCardView(title: NSLocalizedString("last_invoice", comment: ""), icon: "calendar", value: "150 KWH")
                            .frame(width: geometry.size.width * 0.31)
                        MeterCardView(title: NSLocalizedString("current_reading", comment: ""), icon: "bolt", value: "120 KWH")
                            .frame(width: geometry.size.width * 0.31)
                    }
                    .padding(5)
                    VStack {
                        HStack {
                            NavigationLink(destination: NewReadingView()) {
                                Text("new_consumption")
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 15)
                                    .foregroundColor(Color.textColorPrimary)
                            }
                            .background(
                                RadialGradient(gradient: Gradient(colors: [Color.buttonMain, Color.buttonSecondary]), center: .center, startRadius: 1, endRadius: 100)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .padding(.horizontal, 10)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        VStack {
                            HStack {
                                Text("last_consumptions")
                                    .font(.title)
                                    .foregroundColor(.primary)
                                    .padding()
                                    .bold()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            List {
                                NavigationLink(destination: NewReadingView()) {
                                    VStack(alignment: .leading) {
                                        Text("1675 KWH")
                                            .font(.headline)
                                            .padding(.bottom, 10)
                                        HStack {
                                            Label("80 KWH", systemImage: "bolt")
                                                .labelStyle(.titleAndIcon)
                                                .foregroundColor(.red)
                                            Spacer()
                                            Label("14/02/2024", systemImage: "calendar")
                                                .labelStyle(.titleAndIcon)
                                                .foregroundColor(.gray)
                                                .padding(.horizontal, 15)
                                        }
                                        .font(.caption)
                                    }
                                }
                            }
                            .scrollContentBackground(.hidden)
                        }
                    }
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
            .background(.primaryBackground)
        }
    }
}

#Preview {
    MeterView()
}
