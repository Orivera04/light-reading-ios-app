import SwiftUI

struct MeterWidgetView: View {
    @State private var isTextVisible = false
    @State private var isFlickering = false
    @State private var viewModel: MeterViewModel

    init(viewModel: MeterViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            if isTextVisible {
                Text(formatedReading(kWh: viewModel.meterInformation.meter.currentReading))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.custom("DigitalNumbers-Regular", size: 40))
                    .foregroundColor(.black)
                Text("kwh")
                    .padding(.trailing, 15)
                    .foregroundColor(.white)
                    .font(.title)
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
    }

    private func formatedReading(kWh: Int?) -> String {
        guard let kWh = kWh else { return "00:00:00" }

        let paddedString = String(format: "%06d", kWh)
        let components = [
            paddedString.prefix(2),
            paddedString.dropFirst(2).prefix(2),
            paddedString.suffix(2)
        ]
        return components.joined(separator: ":")
    }
}
