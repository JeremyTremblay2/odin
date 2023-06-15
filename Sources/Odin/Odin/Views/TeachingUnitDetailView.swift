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
                                    .frame(width: 24)
                                    .foregroundColor(.blue)
                                    .padding(.leading, 16)
                                    .padding(.trailing, 24)
                            }
                            else {
                                Image(systemName: "lock.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16)
                                    .foregroundColor(.blue)
                                    .padding(.leading, 16)
                                    .padding(.trailing, 24)
                            }
                        }
                        ViewWithLineView(view : SubjectView(subject: subject))
                    }
                    .padding(.top, 40)
                    .onDisappear() {
                        subject.onEdited(isCancelled: true)
                    }
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                Button(action: {
                    teachingUnitVM.onEditing()
                }) {
                    Text("Modifier")
                }
                Button(action:{
                    self.teachingUnitVM.onAdding()
                    teachingUnitVM.addedItem?.onEditing()
                }) {
                    Text("Ajouter")
                }
            }
            .sheet(isPresented: $teachingUnitVM.isAdding){
                NavigationStack{
                    SubjectView(subject: teachingUnitVM.addedItem!, fieldsEditable: true)
                        .toolbar{
                            ToolbarItem(id: "add", placement: .confirmationAction){
                                Button(action: {
                                    self.teachingUnitVM.addedItem?.onEdited()
                                    self.teachingUnitVM.onAdded()
                                }) {
                                    Text("Ajouter")
                                }
                            }
                            ToolbarItem(id: "cancel", placement: .cancellationAction){
                                Button(action: {
                                    self.teachingUnitVM.onAdded(isCancelled: true)
                                }) {
                                    Text("Annuler")
                                }
                            }
                        }
                        .navigationBarTitle("Ajout d'une matière")
                }
            }
            .sheet(isPresented: $teachingUnitVM.isEditing) {
                NavigationStack {
                    EditTeachingUnitView(teachingUnitVM: teachingUnitVM.editedCopy!)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Enregistrer") {
                                    teachingUnitVM.onEdited()
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
        TeachingUnitDetailView(odinVM: OdinVM(withPersistenceStrategy: JsonPersistenceStrategy()),
                               teachingUnitVM: TeachingUnitVM(withTeachingUnit: generateOdin().teachingUnits.first!))
    }
}
