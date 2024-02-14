//
//  MeterView.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 13/2/24.
//

import SwiftUI

struct MeterView: View {
    @State private var isTextVisible = false
    @State private var isFlickering = false

    var body: some View {
        VStack {
            HStack {
                if isTextVisible {
                    Text("00:16:64")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .font(.custom("DigitalNumbers-Regular", size: 40))
                        .foregroundColor(.black)
                    Text("kwH")
                        .padding(.trailing, 15)
                        .foregroundColor(.white)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .background(Color.meterBackground.opacity(isFlickering ? 0.5 : 1.0))
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.meterStroke, lineWidth: 8)
            )
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                    withAnimation {
                        isTextVisible.toggle()
                    }
                }
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    withAnimation {
                        isFlickering.toggle()
                    }
                }
            }
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("last_billing_period")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .padding(.leading, 12)
                        Spacer()
                        Image(systemName: "clock")
                            .imageScale(.medium)
                            .foregroundColor(.blue)
                            .padding(12)
                    }
                    Text("10/11/1997")
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 12)
                }
                .frame(height: 130)
                .background(.backgrounCardDefault)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("last_invoice")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .padding(.leading, 12)
                        Spacer()
                        Image(systemName: "calendar")
                            .imageScale(.medium)
                            .foregroundColor(.blue)
                            .padding(12)
                    }

                    Text("150 KWH")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 12)
                }
                .frame(height: 130)
                .background(.backgrounCardDefault)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("current_reading")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .padding(.leading, 12)
                        Image(systemName: "bolt")
                            .imageScale(.medium)
                            .foregroundColor(.blue)
                            .padding(12)
                    }

                    Text("120 KWH")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 12)
                }
                .frame(height: 130)
                .background(.backgrounCardDefault)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            }
            .padding(10)

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
                        NavigationLink(destination: NewReadingView()) {
                            VStack(alignment: .leading) {
                                Text("1665 KWH")
                                    .font(.headline)
                                    .padding(.bottom, 10)
                                HStack {
                                    Label("80 KWH", systemImage: "bolt")
                                        .labelStyle(.titleAndIcon)
                                        .foregroundColor(.yellow)
                                    Spacer()
                                    Label("13/02/2024", systemImage: "calendar")
                                        .labelStyle(.titleAndIcon)
                                        .foregroundColor(.gray)
                                        .padding(.horizontal, 15)
                                }
                                .font(.caption)
                            }
                        }
                        NavigationLink(destination: NewReadingView()) {
                            VStack(alignment: .leading) {
                                Text("1663 KWH")
                                    .font(.headline)
                                    .padding(.bottom, 10)
                                HStack {
                                    Label("78 KWH", systemImage: "bolt")
                                        .labelStyle(.titleAndIcon)
                                        .foregroundColor(.green)
                                    Spacer()
                                    Label("12/02/2024", systemImage: "calendar")
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
}

#Preview {
    MeterView()
}
