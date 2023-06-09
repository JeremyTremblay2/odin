//
//  Bloc.swift
//  Odin
//
//  Created by etudiant on 25/05/2023.
//

import Foundation

public struct Bloc : Identifiable, Hashable, CustomStringConvertible {
    public let id: UUID
    public var titleName: String
    public var teachingUnits: [TeachingUnit]
    
    public var average: Float? {
        let totalCoefficient = teachingUnits.reduce(0.0) { $0 + ($1.average == nil ? 0.0 : $1.coefficient) }
        let weightedGrades = teachingUnits.reduce(0.0) { $0 + ($1.average ?? 0.0) * ($1.average != nil ? $1.coefficient : 0.0) }
        
        if totalCoefficient > 0.0 {
            return weightedGrades / totalCoefficient
        } else {
            return nil
        }
    }
    
    public var description: String {
        "[\(id)] \(titleName) - \(average != nil ? String(average!) : "No notes")\n"
    }
    
    public init(withId id: UUID, andTitle titleName: String, andTeachingUnits teachingUnits: [TeachingUnit]? = nil) {
        self.id = id
        self.titleName = titleName
        self.teachingUnits = teachingUnits ?? []
    }
    
    public init(withTitle titleName: String, andTeachingUnits teachingUnits: [TeachingUnit]? = nil) {
        id = UUID()
        self.titleName = titleName
        self.teachingUnits = teachingUnits ?? []
    }
    
    public static func == (lhs: Bloc, rhs: Bloc) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
