import Foundation
import SwiftUI

struct CapsuleSlider: View {
    @Binding var average: Float
    
    var minValue: Float
    var maxValue: Float
    
    var backgroundColor: Color
    var foregroundColor: Color
    
    var paddingTrailing: CGFloat = 52
    var height: CGFloat = 20
    
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
                        .foregroundColor(foregroundColor)
                        
                    
                    Text("\(average, specifier: "%.2f")")
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
        }
        .frame(height: height)
    }
    
    private func sliderWidth(in geometry: GeometryProxy) -> CGFloat {
        // Normalize average value between 0 and 1
        let totalWidth = geometry.size.width - paddingTrailing
        let normalizedValue = CGFloat((average - minValue) / (maxValue - minValue))
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
