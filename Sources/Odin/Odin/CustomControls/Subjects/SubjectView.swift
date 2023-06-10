//
//  NoteDetailsView.swift
//  Odin
//
//  Created by etudiant on 26/05/2023.
//

import Foundation
import SwiftUI
import Model

public struct SubjectView: View {
    @ObservedObject var subject: SubjectVM
    var fieldsEditable: Bool = false
    
    private var areFielsEditables: Bool {
        !(subject.isEditing && fieldsEditable)
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                TextField("Nom de la matière", text: $subject.titleName)
                    .padding(.leading, 24)
                    .disabled(areFielsEditables)
                Spacer()
                TextField("Coeff", value: $subject.coefficient, formatter: NumberFormatter())
                    .disabled(areFielsEditables)
                    .frame(width: 36)
            }
            .padding(.bottom, 16)
            CapsuleSliderView(average: $subject.average, isEditable: $subject.isEditing, valueToChangeColor: 10, minValue: 0, maxValue: 20,
                          backgroundColor: .clear, foregroundColor: .red, otherForegroundColor: .green)
        }
        .padding(.trailing, 16)
    }
}

struct SubjectView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectView(subject: SubjectVM(withSubject: generateOdin().teachingUnits.first!.subjects.first!), fieldsEditable: true)
    }
}
