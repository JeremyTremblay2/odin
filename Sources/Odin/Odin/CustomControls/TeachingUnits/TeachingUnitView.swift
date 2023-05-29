//
//  TeachingUnitView.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import SwiftUI
import Model

public struct TeachingUnitView: View {
    @ObservedObject var teachingUnit: TeachingUnitVM
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("UE\(teachingUnit.model.unitNumber) : ")
                    .padding(.leading, 24)
                TextField("Nom de l'UE", text: $teachingUnit.model.titleName)
                    .disabled(!teachingUnit.isEdited)
                Spacer()
                TextField("Coeff", value: $teachingUnit.model.coefficient, formatter: NumberFormatter())
                    .disabled(!teachingUnit.isEdited)
                    .frame(width: 36)
            }
            .padding(.bottom, 16)
            CapsuleSliderView(average: .constant(teachingUnit.original.average), isEditable: $teachingUnit.isEdited, valueToChangeColor: 10,
                              minValue: 0, maxValue: 20,
                              backgroundColor: .clear, foregroundColor: .red, otherForegroundColor: .green)
        }
        .padding(.trailing, 16)
    }
}

struct TeachingUnitView_Previews: PreviewProvider {
    static var previews: some View {
        TeachingUnitView(teachingUnit: TeachingUnitVM(withTeachingUnit: generateOdin().teachingUnits.first!))
    }
}
