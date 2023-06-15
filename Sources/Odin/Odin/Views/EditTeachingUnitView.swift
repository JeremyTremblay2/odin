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
    @ObservedObject var teachingUnitVM: TeachingUnitVM
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("UE\(teachingUnitVM.unitNumber) : ")
                        TextField("Name", text: $teachingUnitVM.titleName)
                    }
                    .font(.largeTitle)
                    .bold()
                    .padding(16)
                    
                    
                    ViewWithLineView(view: TeachingUnitView(teachingUnit: teachingUnitVM))
                        .padding(16)
                        .padding(.leading, 34)
                    
                    HStack(spacing: 0) {
                        Image(systemName: "multiply.circle.fill")
                        Text("Coefficient : ")
                            .padding(.leading, 10)
                        TextField("Coefficient", value: $teachingUnitVM.coefficient, formatter: NumberFormatter())
                    }
                    .padding(.top, 20)
                    .padding(.leading, 16)
                    
                    List {
                        ForEach(teachingUnitVM.subjectsVM) { subject in
                            HStack(alignment: .center) {
                                Button(action: {
                                    subject.average = nil
                                }) {
                                    VStack(alignment: .center) {
                                        Image(systemName: "multiply.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 24)
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding(.leading, 16)
                                .padding(.trailing, 10)
                                
                                SubjectView(subject: subject, fieldsEditable: true)
                                    .padding(.bottom, 16)
                                    .padding(.top, -10)
                            }
                            .swipeActions(edge:.trailing){
                                Button(role: .destructive) {
                                    self.teachingUnitVM.onDeleted(subject)
                                } label: {
                                    Label("Supprimer", systemImage: "trash")
                                }
                            }
                            .onAppear() {
                                subject.onEditing()
                            }
                            .padding(.top, 40)
                            .listRowInsets(EdgeInsets())
                        }
                    }
                    .padding(0)
                    .listStyle(PlainListStyle())
                    
                    Spacer()
                    HStack(alignment: .center) {
                        Button("Ajouter une matière", action: {
                            teachingUnitVM.addSubject()
                        })
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
        .onAppear() { // used to allow the user to edit the other view of the teaching unit.
            teachingUnitVM.onEditing()
        }
    }
}

struct EditTeachingUnitView_Previews: PreviewProvider {
    static var previews: some View {
        EditTeachingUnitView(teachingUnitVM: TeachingUnitVM(withTeachingUnit: generateOdin().teachingUnits.first!))
    }
}
