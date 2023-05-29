//
//  BlocVM.swift
//  Odin
//
//  Created by etudiant on 29/05/2023.
//

import Foundation
import Model

extension Bloc {
    struct Data: Identifiable {
        public let id: UUID
        public private (set) var titleName: String
        public private (set) var teachingUnits: [TeachingUnit.Data]
        public var average: Float? {
            let totalCoefficient = teachingUnits.reduce(0.0) { $0 + ($1.average == nil ? 0.0 : $1.coefficient) }
            let weightedGrades = teachingUnits.reduce(0.0) { $0 + ($1.average ?? 0.0) * ($1.average != nil ? $1.coefficient : 0.0) }
            
            if totalCoefficient > 0.0 {
                return weightedGrades / totalCoefficient
            } else {
                return nil
            }
        }
    }
    
    var data: Data { Data(id: self.id, titleName: self.titleName, teachingUnits: self.teachingUnits.map { $0.data }) }
    
    mutating func update(fromData data: Data) {
        guard data.id == self.id else {
            return
        }
        self.titleName = data.titleName
        self.teachingUnits = data.teachingUnits.map{ TeachingUnit(withId: $0.id, andName: $0.titleName, andUnitNumber: $0.unitNumber,
                                                                  andCoeff: $0.coefficient, andSubjects: $0.subjects.map {
            Subject(withId: $0.id, andName: $0.titleName, andCoeff: $0.coefficient, andAverage: $0.average)
        } )}
    }
}

class BlocVM : ObservableObject {
    var original: Bloc
    @Published var model: Bloc.Data
    
    init(withBloc bloc: Bloc) {
        self.original = bloc
        self.model = original.data
    }
}
