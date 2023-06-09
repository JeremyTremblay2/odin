//
//  TeachingUnitVM.swift
//  Odin
//
//  Created by etudiant on 26/05/2023.
//

import Foundation
import Model

/*extension TeachingUnit {
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
        self.subjects = data.subjects.map{ Subject(withId: $0.id, andName: $0.titleName, andCoeff: $0.coefficient, andAverage: $0.average)}
    }
}*/

class TeachingUnitVM : ObservableObject, Identifiable, Equatable {
    init() {}
    
    init(withTeachingUnit teachingUnit: TeachingUnit) {
        self.model = teachingUnit
    }
    
    @Published var model: TeachingUnit = TeachingUnit(withId: UUID(), andName: "Unité d'enseignement", andUnitNumber: 5, andCoeff: 1) {
        didSet {
            if self.model.titleName != self.titleName {
                self.model.titleName = self.titleName
            }
            if self.model.unitNumber != self.unitNumber {
                self.model.unitNumber = self.unitNumber
            }
            if self.model.coefficient != self.coefficient {
                self.model.coefficient = self.coefficient
            }
            if !self.model.subjects.compare(to: self.subjectsVM.map({ $0.model })) {
                self.subjectsVM = self.model.subjects.map({ SubjectVM(withSubject: $0) })
            }
        }
    }
    
    @Published var titleName: String = "" {
        didSet {
            if self.model.titleName != self.titleName {
                self.model.titleName = self.titleName
            }
        }
    }
    
    @Published var unitNumber: Int = 0 {
        didSet {
            if self.model.unitNumber != self.unitNumber {
                self.model.unitNumber = self.unitNumber
            }
        }
    }
    
    @Published var coefficient: Float = 0 {
        didSet {
            if self.model.coefficient != self.coefficient {
                self.model.coefficient = self.coefficient
            }
        }
    }
    
    @Published var subjectsVM: [SubjectVM] = [] {
        didSet {
            let subjectModels = self.subjectsVM.map({ $0.model })
            if !self.model.subjects.compare(to: subjectModels){
                self.model.subjects = subjectsVM.map({ $0.model })
            }
        }
    }
    
    public var id: UUID { model.id }
    
    @Published var isEdited = false
    
    static func == (lhs: TeachingUnitVM, rhs: TeachingUnitVM) -> Bool {
        lhs.id == rhs.id
    }
    
    func onEditing() {
        //copy = TeachingUnitVM(withTeachingUnit: original)
        isEdited = true
    }
    
    func onEdited(isCancelled cancelled: Bool = false) {
        if (!cancelled) {
            //original = copy?.original ?? original
        }
        isEdited = false
    }
    
    func addSubject() {
        let subject = Subject(withName: "Matière", andCoeff: 1)
        model.subjects.append(subject)
        subjects.append(SubjectVM(withSubject: subject))
    }
    
    func removeSubject(toBeRemoved subject: Subject) {
        guard let index = model.subjects.firstIndex(of: subject) else {
            return
        }
        model.subjects.remove(at: index)
    }
}
