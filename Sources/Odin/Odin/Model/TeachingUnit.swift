//
//  TeachingUnit.swift
//  Odin
//
//  Created by etudiant on 25/05/2023.
//

import Foundation

struct TeachingUnit: Identifiable, Hashable, CustomStringConvertible {
    public let id: UUID
    public private (set) var titleName: String
    public private (set) var unitNumber: Int
    public private (set) var coefficient: Float
    public private (set) var subjects: [Subject]
    
    public var average: Float? {
        let totalCoefficient = subjects.reduce(0.0) { $0 + Float($1.coefficient)! }
        let weightedGrades = subjects.reduce(0.0) { $0 + ($1.average ?? 0.0) * Float($1.coefficient)! }
        
        if totalCoefficient > 0.0 {
            return weightedGrades / totalCoefficient
        } else {
            return nil
        }
    }
    
    public var description: String {
        var name: String = "[\(id)] U\(unitNumber) \(titleName) - \(average != nil ? String(average!) : "No notes") [Coeff: \(coefficient)]\n"
        for subject in subjects {
            name.append(subject.description)
        }
        return name
    }
    
    public init(withId id: UUID, andName titleName: String, andUnitNumber unitNumber: Int, andCoeff coefficient: Float, andSubjects subjects: [Subject]) {
        self.id = id
        self.titleName = titleName
        self.unitNumber = unitNumber
        self.coefficient = coefficient
        self.subjects = subjects
    }
    
    public init(withName titleName: String, andUnitNumber unitNumber: Int, andCoeff coefficient: Float, andSubjects subjects: [Subject]) {
        id = UUID()
        self.titleName = titleName
        self.unitNumber = unitNumber
        self.coefficient = coefficient
        self.subjects = subjects
    }
    
    public static func == (lhs: TeachingUnit, rhs: TeachingUnit) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
