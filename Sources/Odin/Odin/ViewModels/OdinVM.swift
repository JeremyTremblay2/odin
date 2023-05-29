//
//  OdinVM.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import Model

class OdinVM : ObservableObject {
    @Published var teachingUnits: [TeachingUnit]
    @Published var blocs: [Bloc]
    
    init(withTeachingUnits teachingUnits: [TeachingUnit], withBlocs blocs: [Bloc]) {
        self.teachingUnits = teachingUnits
        self.blocs = blocs
    }
    
    func update(withTeachingUnitVM teachingUnitVM: TeachingUnitVM) {
        if let i = teachingUnits.firstIndex(where: { $0.id == teachingUnitVM.original.id}) {
            teachingUnits[i] = teachingUnitVM.original
        }
        else {
            teachingUnits.append(teachingUnitVM.original)
        }
    }
    
    func remove(withTeachingUnitVM teachingUnitVM: TeachingUnitVM) {
        if let i = teachingUnits.firstIndex(where: { $0.id == teachingUnitVM.original.id}) {
            teachingUnits.remove(at: i)
        }
    }
}
