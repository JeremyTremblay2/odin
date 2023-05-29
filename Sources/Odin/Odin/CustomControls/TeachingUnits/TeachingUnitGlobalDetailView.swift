//
//  TeachingUnitDetailView.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import SwiftUI

public struct TeachingUnitGlobalDetailView: View {
    var coefficient: Float
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "multiply.circle.fill")
                Text("Coefficient : \(String(coefficient))")
                    .padding(.leading, 10)
            }
            .padding(.bottom, 10)
            HStack(spacing: 0) {
                Image(systemName: "note.text")
                Text("Détail des notes")
                    .padding(.leading, 10)
            }
        }
    }
}

struct TeachingUnitGlobalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TeachingUnitGlobalDetailView(coefficient: 6)
    }
}
