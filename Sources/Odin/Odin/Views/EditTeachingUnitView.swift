//
//  EditTeachingUnitView.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import SwiftUI
import Model

public struct EditTeachingUnitView: View {
    @Binding var teachingUnitData: TeachingUnit.Data
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("UE\(teachingUnitData.unitNumber) : ")
                        TextField("Name", text: $teachingUnitData.titleName)
                    }
                    .font(.largeTitle)
                    .bold()
                    .padding(16)
                    
                    
                    /*TeachingUnitWithLineView(teachingUnit: teachingUnitData)
                     .padding(16)
                     .padding(.leading, 34)*/
                    
                    HStack(spacing: 0) {
                        Image(systemName: "multiply.circle.fill")
                        Text("Coefficient : ")
                            .padding(.leading, 10)
                        TextField("Coefficient", value: $teachingUnitData.coefficient, formatter: NumberFormatter())
                    }
                    .padding(.top, 20)
                    .padding(.leading, 16)
                    
                    ForEach(teachingUnitData.subjects) { subject in
                        HStack(alignment: .center) {
                            Button(action: {}) {
                                Image(systemName: "trash.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16)
                                    .foregroundColor(.blue)
                                
                            }
                            
                            .padding(.leading, 16)
                            .padding(.trailing, 24)
                            
                            SubjectWithLineView(subject: SubjectVM(withSubject: subject))
                        }
                        .padding(.top, 40)
                    }
                    
                    Spacer()
                    HStack(alignment: .center) {
                        Button("Ajouter une matière", action: {})
                            .padding(.horizontal, 26)
                            .padding(.vertical, 8)
                            .background(.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(minHeight: geometry.size.height)
            }
            .frame(width: geometry.size.width)
        }
    }
}

struct EditTeachingUnitView_Previews: PreviewProvider {
    static var previews: some View {
        EditTeachingUnitView(teachingUnitData: .constant(generateOdin().teachingUnits.first!.data))
    }
}
