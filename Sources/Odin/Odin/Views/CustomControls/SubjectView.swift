//
//  NoteDetailsView.swift
//  Odin
//
//  Created by etudiant on 26/05/2023.
//

import Foundation
import SwiftUI

public struct NoteDetailView: View {
    @ObservedObject var subject: SubjectVM
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(subject.model.titleName)
                Spacer()
                Text(String(subject.model.coefficient))
            }
            .padding(16)
            CapsuleSlider(average: $subject.model.average, valueToChangeColor: 10, minValue: 0, maxValue: 20,
                          backgroundColor: .clear, foregroundColor: .red, otherForegroundColor: .green)
                .padding(.horizontal, 16)
        }
        .padding(.trailing, 16)
    }
}
