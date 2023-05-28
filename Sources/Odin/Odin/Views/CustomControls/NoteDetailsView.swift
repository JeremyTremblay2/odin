//
//  NoteDetailsView.swift
//  Odin
//
//  Created by etudiant on 26/05/2023.
//

import Foundation
import SwiftUI

public struct NoteDetailView: View {
    //var subject: Subject
    @State private var average: Float = 0
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("UE Génie Logiciel")
                Spacer()
                Text("6")
            }
            .padding(16)
            CapsuleSlider(average: $average, minValue: 0, maxValue: 20, backgroundColor: .clear, foregroundColor: .green)
                .padding(.horizontal, 16)
        }
        .padding(.trailing, 16)
    }
}
