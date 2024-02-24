//
//  ManageReadingView.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 13/2/24.
//

import SwiftUI

struct ManageReadingView: View {
    private var isNewRecord: Bool = false
    private var meterId: String

    @State private var redirectToMeter: Bool = false
    @StateObject private var viewModel: ManageReadingViewModel

    init(reading: Reading?, meterId: String, isNewRecord: Bool) {
        if let reading = reading {
            _viewModel = StateObject(wrappedValue: ManageReadingViewModel(reading: reading))
        } else {
            _viewModel = StateObject(wrappedValue: ManageReadingViewModel(meterId: meterId))
        }

        self.meterId = meterId
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
                NavigationLink(destination: ManageMeterView(meter: nil, isNewRecord: true)) {
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
                            Text("kwh")
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
                        Toggle("save_new_billing_cycle", isOn: $viewModel.reading.isLastCycle)
                    }
                }
            }
            Button(action: { viewModel.manageReading(isNewRecord: isNewRecord) }) {
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
                            Button(action: viewModel.deleteMeter) {
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
                   redirectToMeter = viewModel.isSuccess || viewModel.isSuccessDeleted
               }
           )
        }
        .navigationDestination(isPresented: $redirectToMeter) {
            MeterView(id: meterId)
        }
        .overlay {
            if viewModel.isLoading {
                LoaderView()
            }
        }
    }
}
