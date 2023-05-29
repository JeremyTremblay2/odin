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
        public var titleName: String
        public private (set) var unitNumber: Int
        public var coefficient: Float
        public var subjects: [Subject.Data]
        public var average: Float? {
            let totalCoefficient = subjects.reduce(0.0) { $0 + ($1.average == nil ? 0.0 : $1.coefficient) }
            let weightedGrades = subjects.reduce(0.0) { $0 + ($1.average ?? 0.0) * ($1.average != nil ? $1.coefficient : 0.0) }
            
            if totalCoefficient > 0.0 {
                return weightedGrades / totalCoefficient
            } else {
                return nil
            }
        }
    }
    
    var data: Data {
        Data(id: self.id, titleName: self.titleName, unitNumber: self.unitNumber,
             coefficient: self.coefficient, subjects: self.subjects.map { $0.data })
    }
    
    mutating func update(fromData data: Data) {
        guard data.id == self.id else {
            return
        }
        self.titleName = data.titleName
        self.unitNumber = data.unitNumber
        self.coefficient = data.coefficient
        self.subjects = data.subjects.map{ Subject(withId: $0.id, andName: $0.titleName, andCoeff: $0.coefficient)}
    }
}

class TeachingUnitVM : ObservableObject {
    var original: TeachingUnit
    
    @Published var model: TeachingUnit.Data = TeachingUnit.Data(id: UUID(), titleName: "", unitNumber: 1, coefficient: 1, subjects: [])
    @Published var isEdited = false
    
    init(withTeachingUnit teachingUnit: TeachingUnit) {
        self.original = teachingUnit
        model = original.data
    }
    
    func onEditing() {
        model = original.data
        isEdited = true
    }
    
    func onEdited(isCancelled cancelled: Bool = false) {
        if (!cancelled) {
            original.update(fromData: model)
        }
        isEdited = false
        model = original.data
    }
    
    func addSubject() {
        original.subjects.append(Subject(withName: "Matière", andCoeff: 1))
    }
    
    func removeSubject(toBeRemoved subject: Subject) {
        guard let index = original.subjects.firstIndex(of: subject) else {
            return
        }
        original.subjects.remove(at: index)
    }
}
