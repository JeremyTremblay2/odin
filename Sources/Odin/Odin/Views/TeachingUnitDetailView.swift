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
    
    var navigationTitle: String {
        "UE\(teachingUnitVM.model.unitNumber) : \(teachingUnitVM.model.titleName)"
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                
                ViewWithLineView(view: TeachingUnitView(teachingUnit: teachingUnitVM))
                    .padding(16)
                    .padding(.leading, 34)
                
                TeachingUnitGlobalDetailView(coefficient: teachingUnitVM.model.coefficient)
                    .padding(.top, 20)
                
                ForEach($teachingUnitVM.subjectsVM) { $subject in
                    HStack(alignment: .center) {
                        Button(action: {
                            subject.isEditing ? subject.onEdited() : subject.onEditing()
                        }) {
                            if subject.isEditing {
                                Image(systemName: "lock.open.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16)
                                    .foregroundColor(.blue)
                                    .padding(.leading, 16)
                                    .padding(.trailing, 24)
                            }
                            else {
                                Image(systemName: "flame")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16)
                                    .foregroundColor(.blue)
                                    .padding(.leading, 16)
                                    .padding(.trailing, 24)
                            }
                        }
                        ViewWithLineView(view : SubjectView(subject: subject.editedCopy ?? subject))
                    }
                    .padding(.top, 40)
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                Button(action: {
                    teachingUnitVM.onEditing()
                }) {
                    Text("Modifier")
                }
            }
            .sheet(isPresented: $teachingUnitVM.isEditing) {
                NavigationStack {
                    EditTeachingUnitView(teachingUnitVM: teachingUnitVM.editedCopy!)
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
