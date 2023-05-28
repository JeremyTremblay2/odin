//
//  TeachingUnitDetailView.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import SwiftUI
import Model

public struct TeachingUnitDetailView: View {
    @ObservedObject var teachingUnit: TeachingUnitVM
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("UE\(teachingUnit.model.unitNumber) : \(teachingUnit.model.titleName)")
                    .font(.largeTitle)
                    .bold()
                    .padding(16)
                
                TeachingUnitWithLineView(teachingUnit: teachingUnit)
                    .padding(16)
                    .padding(.leading, 34)
                
                TeachingUnitGlobalDetailView(coefficient: teachingUnit.model.coefficient)
                    .padding(.top, 20)
                
                ForEach(teachingUnit.model.subjects) { subject in
                    HStack(alignment: .center) {
                        Image(systemName: "lock.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16)
                            .foregroundColor(.blue)
                            .padding(.leading, 16)
                            .padding(.trailing, 24)
                        
                        SubjectWithLineView(subject: SubjectVM(withSubject: subject))
                    }
                    .padding(.top, 40)
                }
            }
        }
    }
}

struct TeachingUnitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TeachingUnitDetailView(teachingUnit: TeachingUnitVM(withTeachingUnit: generateOdin().teachingUnits.first!))
    }
}
