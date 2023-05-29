import Foundation
import SwiftUI

struct CapsuleSliderView: View {
    @Binding var average: Float?
    @Binding var isEditable: Bool
    var valueToChangeColor: Float
    
    var minValue: Float
    var maxValue: Float
    
    var backgroundColor: Color
    var foregroundColor: Color
    var otherForegroundColor: Color
    
    var paddingTrailing: CGFloat = 52
    var height: CGFloat = 20
    
    private var capsuleColor: Color {
        average == nil ? otherForegroundColor : (average! < valueToChangeColor ? foregroundColor : otherForegroundColor)
    }
    
    private var textValue: String {
        average == nil ? "Aucune note" : String(format: "%.2f", average!)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(width: geometry.size.width - paddingTrailing)
                    .foregroundColor(backgroundColor)
                    .gesture(DragGesture()
                        .onChanged { value in
                            self.updateSliderPosition(with: value.location.x, geometry: geometry)
                        }
                    )
                    .onTapGesture { value in
                        self.updateSliderPosition(with: value.x, geometry: geometry)
                    }
                
                HStack(alignment: .top) {
                    Capsule()
                        .frame(width: self.sliderWidth(in: geometry))
                        .foregroundColor(capsuleColor)
                        
                    
                    Text(textValue)
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(DragGesture()
                    .onChanged { value in
                        self.updateSliderPosition(with: value.location.x, geometry: geometry)
                    }
                )
                .onTapGesture { value in
                    self.updateSliderPosition(with: value.x, geometry: geometry)
                }
            }
            .disabled(!$isEditable.wrappedValue)
        }
        .frame(height: height)
    }
    
    private func sliderWidth(in geometry: GeometryProxy) -> CGFloat {
        // Normalize average value between 0 and 1
        let totalWidth = geometry.size.width - paddingTrailing
        let normalizedValue = CGFloat((average ?? minValue - minValue) / (maxValue - minValue))
        return max(20, totalWidth * normalizedValue)
    }
    
    private func updateSliderPosition(with value: CGFloat, geometry: GeometryProxy) {
        let totalWidth = geometry.size.width - paddingTrailing
        let normalizedValue = value / totalWidth
        let clampedValue = min(max(normalizedValue, 0), 1)
        // Denormalize average value
        average = Float(clampedValue) * (maxValue - minValue) + minValue
    }
}

struct CapsuleSliderView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleSliderView(average: .constant(15.33), isEditable: .constant(true), valueToChangeColor: 8, minValue: 0, maxValue: 20,
                          backgroundColor: .clear, foregroundColor: .red, otherForegroundColor: .green)
    }
}
