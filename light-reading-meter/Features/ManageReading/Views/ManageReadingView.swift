//
//  ManageReadingView.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 13/2/24.
//

import SwiftUI

struct ManageReadingView: View {
    @State private var redirectToHome: Bool = false
    @State private var isNewRecord: Bool
    @StateObject private var viewModel: ManageReadingViewModel
   
    init(reading: Reading?, isNewRecord: Bool) {
        if let reading = reading {
            _viewModel = StateObject(wrappedValue: ManageReadingViewModel(reading: reading))
        } else {
            _viewModel = StateObject(wrappedValue: ManageReadingViewModel())
        }
        
        self.isNewRecord = isNewRecord
    }
    
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
                NavigationLink(destination: ManageMeterView(meter: nil)) {
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
                            TextField("reading", value: $viewModel.reading.kWhReading, formatter: NumberFormatter())
                            Text("KWH")
                        }
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.icon)
                            DatePicker(selection: $viewModel.reading.dateOfReading, in: ...Date.now, displayedComponents: .date) {
                                Text("select_date")
                            }
                        }
                    }

                    Section(header: Text("new_billing_cycle")) {
                        Toggle("save_new_billing_cycle", isOn: $viewModel.reading.isLastCicle)
                    }
                }
            }
            Button(action: { viewModel.manageReading() }) {
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
            if !self.isNewRecord {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
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
        .alert(isPresented: $viewModel.showMessage) {
            Alert(
               title: Text(viewModel.messageTitle),
               message: Text(viewModel.messageBody),
               dismissButton: .default(Text("ok")) {
                   redirectToHome = viewModel.isSuccess
               }
           )
        }
        NavigationLink(destination: HomeView(), isActive: $redirectToHome) {
            EmptyView()
        }
    }
}
