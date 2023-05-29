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
    @ObservedObject var odinVM: OdinVM
    @ObservedObject var teachingUnitVM: TeachingUnitVM
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("UE\(teachingUnitVM.model.unitNumber) : \(teachingUnitVM.model.titleName)")
                    .font(.largeTitle)
                    .bold()
                    .padding(16)
                
                TeachingUnitWithLineView(teachingUnit: teachingUnitVM)
                    .padding(16)
                    .padding(.leading, 34)
                
                TeachingUnitGlobalDetailView(coefficient: teachingUnitVM.model.coefficient)
                    .padding(.top, 20)
                
                ForEach(teachingUnitVM.original.subjects) { subject in
                    let subjectVM = SubjectVM(withSubject: subject)
                    HStack(alignment: .center) {
                        Button(action: {
                            subjectVM.isEdited ? subjectVM.onEdited() : subjectVM.onEditing()
                        }) {
                            Image(systemName: (subjectVM.isEdited ? "lock.open.fill" : "lock.fill"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                                .foregroundColor(.blue)
                                .padding(.leading, 16)
                                .padding(.trailing, 24)
                        }
                        SubjectWithLineView(subject: subjectVM)
                    }
                    .padding(.top, 40)
                }
            }
            .toolbar {
                Button(action: {
                    teachingUnitVM.onEditing()
                }) {
                    Text("Modifier")
                }
            }
            .sheet(isPresented: $teachingUnitVM.isEdited) {
                NavigationStack {
                    EditTeachingUnitView(teachingUnitVM: teachingUnitVM, teachingUnitData: $teachingUnitVM.model)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Enregistrer") {
                                    teachingUnitVM.onEdited()
                                    odinVM.update(withTeachingUnitVM: teachingUnitVM)
                                }
                            }
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Annuler") {
                                    teachingUnitVM.onEdited(isCancelled: true)
                                }
                            }
                        }
                }
            }
        }
    }
}

struct TeachingUnitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TeachingUnitDetailView(odinVM: OdinVM(withTeachingUnits: generateOdin().teachingUnits, withBlocs: generateOdin().blocs),
                               teachingUnitVM: TeachingUnitVM(withTeachingUnit: generateOdin().teachingUnits.first!))
    }
}
