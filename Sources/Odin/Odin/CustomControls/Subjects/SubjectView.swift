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
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                TextField("Nom de la matière", text: $subject.model.titleName)
                    .padding(.leading, 24)
                    .disabled(!subject.isEdited && !fieldsEditable)
                Spacer()
                TextField("Coeff", value: $subject.model.coefficient, formatter: NumberFormatter())
                    .disabled(!subject.isEdited && !fieldsEditable)
                    .frame(width: 36)
            }
            .padding(.bottom, 16)
            CapsuleSliderView(average: $subject.model.average, isEditable: $subject.isEdited, valueToChangeColor: 10, minValue: 0, maxValue: 20,
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
