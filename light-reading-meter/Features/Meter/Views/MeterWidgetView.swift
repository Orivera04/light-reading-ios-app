import SwiftUI

struct MeterWidgetView: View {
    @State private var isTextVisible = false
    @State private var isFlickering = false
    
    var body: some View {
        HStack {
            if isTextVisible {
                Text("00:16:64")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.custom("DigitalNumbers-Regular", size: 40))
                    .foregroundColor(.black)
                Text("kwH")
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
}

#Preview {
    MeterWidgetView()
}
