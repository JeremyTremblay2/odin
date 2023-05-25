//
//  CapsuleSlider.swift
//  Odin
//
//  Created by etudiant on 25/05/2023.
//

import Foundation
import SwiftUI

struct CapsuleSlider: View {
    @Binding var average: Float
    
    var minValue: Float
    var maxValue: Float
    
    var height: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(width: geometry.size.width)
                    .foregroundColor(.gray)
                    .gesture(DragGesture()
                        .onChanged { value in
                            self.updateSliderPosition(with: value.location.x, geometry: geometry)
                        }
                    )
                    .onTapGesture { value in
                        self.updateSliderPosition(with: value.x, geometry: geometry)
                    }
                
                Capsule()
                    .frame(width: self.sliderWidth(in: geometry))
                    .foregroundColor(.blue)
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
        let totalWidth = geometry.size.width
        let normalizedValue = CGFloat((average - minValue) / (maxValue - minValue))
        return totalWidth * normalizedValue
    }
    
    private func updateSliderPosition(with value: CGFloat, geometry: GeometryProxy) {
        let totalWidth = geometry.size.width
        let normalizedValue = value / totalWidth
        let clampedValue = min(max(normalizedValue, 0), 1)
        // Denormalize average value
        average = Float(clampedValue) * (maxValue - minValue) + minValue
    }
}
