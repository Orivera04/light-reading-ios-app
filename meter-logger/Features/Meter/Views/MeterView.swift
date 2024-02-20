//
//  MeterView.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 13/2/24.
//

import SwiftUI

struct MeterView: View {
    @State private var redirectToMeter: Bool = false
    @State private var redirectToHome: Bool = false
    @StateObject var viewModel: MeterViewModel

    init(id: UUID) {
        _viewModel = StateObject(wrappedValue: MeterViewModel(id: id))
    }

    var body: some View {
        GeometryReader{ geometry in
            VStack {
                VStack{
                    MeterWidgetView(viewModel: viewModel)
                }
                VStack {
                    HStack {
                        MeterCardView(title: NSLocalizedString("last_invoice", comment: ""), icon: "calendar", value: viewModel.meter.lastInvoiceString)
                            .frame(width: geometry.size.width * 0.31)

                        MeterCardView(title: NSLocalizedString("last_reading", comment: ""), icon: "clock", value: viewModel.meter.lastBillingKwhString)
                            .frame(width: geometry.size.width * 0.31)
                        MeterCardView(title: NSLocalizedString("current_reading", comment: ""), icon: "bolt", value: viewModel.meter.currentReadingString)
                            .frame(width: geometry.size.width * 0.31)
                    }
                    .padding(5)
                    VStack {
                        HStack {
                            NavigationLink(destination: ManageReadingView(reading: nil, meterId: viewModel.meter.id, isNewRecord: true)) {
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
                            if let readings = viewModel.meter.lastReadings {
                                List(readings) { reading in
                                    NavigationLink(destination: ManageReadingView(reading: reading, meterId: viewModel.meter.id, isNewRecord: false)) {
                                        VStack(alignment: .leading) {
                                            Text(reading.kilowatsReadingString)
                                                .font(.headline)
                                                .padding(.bottom, 10)
                                            HStack {
                                                Label(reading.kilowatsAcumulatedReadingString, systemImage: "bolt")
                                                    .labelStyle(.titleAndIcon)
                                                    .foregroundColor(ColorsStyle.colorForKWh(kWh: reading.accumulatedkWhReading, threshold: viewModel.meter.desiredMonthlyKWH))
                                                Spacer()
                                                Label(reading.dateOfReadingString, systemImage: "calendar")
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
                            else {
                                List {
                                    HStack {
                                        Image(systemName: "exclamationmark.triangle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            .padding()
                                            .foregroundColor(.gray)

                                        Text("no_readings_found")
                                            .font(.headline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background(.primaryBackground)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button(action: {
                                redirectToMeter = true
                            }) {
                                Label("edit", systemImage: "pencil")
                            }
                            Button(action: {
                                viewModel.deleteMeter(id: viewModel.meter.id)
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
            .navigationDestination(isPresented: $redirectToMeter) {
                ManageMeterView(meter: viewModel.meter, isNewRecord: false)
            }
            .navigationDestination(isPresented: $redirectToHome) {
                HomeView()
            }
        }
        .alert(isPresented: $viewModel.showMessage) {
            Alert(
               title: Text(viewModel.messageTitle),
               message: Text(viewModel.messageBody),
               dismissButton: .default(Text("ok")) {
                   redirectToHome = viewModel.isSucessDeleted
               }
           )
        }
        .overlay {
            if viewModel.isLoading {
                LoaderView()
            }
        }
    }
}
