//
//  ContentView.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 6/2/24.
//

import SwiftUI

struct HomeView: View {
    @State var presentSideMenu = false

    var body: some View {
        NavbarView(presentSideMenu: $presentSideMenu) {
            NavigationStack {
                VStack {
                    HStack {
                        NavigationLink(destination: CreateMeterView()) {
                            Text("register_meter")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                                .foregroundColor(Color.textColorPrimary)
                        }
                        .background(
                            RadialGradient(gradient: Gradient(colors: [Color.buttonMain, Color.buttonSecondary]), center: .center, startRadius: 1, endRadius: 100)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    VStack {
                        HStack {
                            Text("my_meters")
                                .font(.title)
                                .foregroundColor(.primary)
                                .padding()
                                .bold()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        List {
                            NavigationLink(destination: MeterView()) {
                                VStack(alignment: .leading) {
                                    Text("Medidor 1")
                                        .font(.headline)
                                        .padding(.bottom, 10)
                                    HStack {
                                        Label("80 KWH", systemImage: "bolt")
                                            .labelStyle(.titleAndIcon)
                                            .foregroundColor(.green)
                                        Spacer()
                                        Label("Oscar", systemImage: "tag")
                                            .labelStyle(.titleAndIcon)
                                            .foregroundColor(.gray)
                                            .padding(.horizontal, 15)
                                    }
                                    .font(.caption)
                                }
                            }
                            NavigationLink(destination: MeterView()) {
                                VStack(alignment: .leading) {
                                    Text("Medidor 2")
                                        .font(.headline)
                                        .padding(.bottom, 10)
                                    HStack {
                                        Label("143 KWH", systemImage: "bolt")
                                            .labelStyle(.titleAndIcon)
                                            .foregroundColor(.yellow)
                                        Spacer()
                                        Label("Johana", systemImage: "tag")
                                            .labelStyle(.titleAndIcon)
                                            .foregroundColor(.gray)
                                    }
                                    .font(.caption)
                                }
                            }
                            NavigationLink(destination: MeterView()) {
                                VStack(alignment: .leading) {
                                    Text("Medidor 3")
                                        .font(.headline)
                                        .padding(.bottom, 10)
                                    HStack {
                                        Label("166 KWH", systemImage: "bolt")
                                            .labelStyle(.titleAndIcon)
                                            .foregroundColor(.red)
                                        Spacer()
                                        Label("Johana", systemImage: "tag")
                                            .labelStyle(.titleAndIcon)
                                            .foregroundColor(.gray)
                                    }
                                    .font(.caption)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
                .background(.primaryBackground)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
