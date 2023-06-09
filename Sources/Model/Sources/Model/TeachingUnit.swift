//
//  TeachingUnit.swift
//  Odin
//
//  Created by etudiant on 25/05/2023.
//

import Foundation

public struct TeachingUnit: Identifiable, Hashable, CustomStringConvertible {
    public let id: UUID
    public var titleName: String
    public var unitNumber: Int
    public var coefficient: Float
    public var subjects: [Subject]
    
    public var average: Float? {
        let totalCoefficient = subjects.reduce(0.0) { $0 + ($1.average == nil ? 0.0 : $1.coefficient) }
        let weightedGrades = subjects.reduce(0.0) { $0 + ($1.average ?? 0.0) * ($1.average != nil ? $1.coefficient : 0.0) }
        
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
    
    public init(withId id: UUID, andName titleName: String, andUnitNumber unitNumber: Int, andCoeff coefficient: Float, andSubjects subjects: [Subject]? = nil) {
        self.id = id
        self.titleName = titleName
        self.unitNumber = unitNumber
        self.coefficient = coefficient
        self.subjects = subjects ?? []
    }
    
    public init(withName titleName: String, andUnitNumber unitNumber: Int, andCoeff coefficient: Float, andSubjects subjects: [Subject]? = nil) {
        id = UUID()
        self.titleName = titleName
        self.unitNumber = unitNumber
        self.coefficient = coefficient
        self.subjects = subjects ?? []
    }
    
    public static func == (lhs: TeachingUnit, rhs: TeachingUnit) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
