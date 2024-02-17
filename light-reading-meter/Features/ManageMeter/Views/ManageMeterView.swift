//
//  ManageMeterView.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 12/2/24.
//

import SwiftUI

struct ManageMeterView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: AdministrationMeterViewModel
    
    init(meter: Meter?) {
        if let meter = meter {
            _viewModel = StateObject(wrappedValue: AdministrationMeterViewModel(meter: meter))
        } else {
            _viewModel = StateObject(wrappedValue: AdministrationMeterViewModel())
        }
    }
    
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
                            TextField("name", text: $viewModel.meter.name)
                        }
                        HStack {
                            Image(systemName: "tag")
                                .foregroundColor(.icon)
                            TextField("tag", text: $viewModel.meter.tag)
                        }
                    }

                    Section(header: Text("maximum_consumption")) {
                        Stepper("\(viewModel.meter.desiredMonthlyKWH) KWH", value: $viewModel.meter.desiredMonthlyKWH, in: 0...1000)
                    }
                }
            }
            Button(action: { viewModel.manageMeter() }) {
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
        .alert(isPresented: $viewModel.showMessage) {
            Alert(
               title: Text(viewModel.messageTitle),
               message: Text(viewModel.messageBody),
               dismissButton: .default(Text("ok")) {
                   if viewModel.isSuccess {
                       presentationMode.wrappedValue.dismiss()
                   }
               }
           )
        }
        NavigationLink(destination: HomeView(), isActive: $viewModel.isSuccess) {
            EmptyView()
        }
        .isDetailLink(false)
    }
}

