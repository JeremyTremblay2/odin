//
//  TeachingUnitVM.swift
//  Odin
//
//  Created by etudiant on 26/05/2023.
//

import Foundation
import Model

extension TeachingUnit {
    struct Data: Identifiable {
        public let id: UUID
        public private (set) var titleName: String
        public private (set) var unitNumber: Int
        public private (set) var coefficient: Float
        public private (set) var subjects: [Subject]
    }
    
    var data: Data {
        Data(id: self.id, titleName: self.titleName, unitNumber: self.unitNumber,
             coefficient: self.coefficient, subjects: self.subjects.map { $0 })
    }
    
    mutating func update(fromData data: Data) {
        guard data.id == self.id else {
            return
        }
        self.titleName = data.titleName
        self.unitNumber = data.unitNumber
        self.coefficient = data.coefficient
        self.subjects = data.subjects
    }
}

class TeachingUnitVM : ObservableObject {
    var original: TeachingUnit
    
    @Published var model: TeachingUnit.Data = TeachingUnit.Data(id: UUID(), titleName: "", unitNumber: 1, coefficient: 1, subjects: [])
    @Published var isEditing = false
    
    init(withTeachingUnit teachingUnit: TeachingUnit) {
        self.original = teachingUnit
        isEditing = true
    }
    
    func onEdited(isCancelled cancelled: Bool = false) {
        if (!cancelled) {
            original.update(fromData: model)
        }
        isEditing = false
        model = original.data
    }
}
