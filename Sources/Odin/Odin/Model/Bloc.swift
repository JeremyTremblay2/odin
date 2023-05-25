//
//  Bloc.swift
//  Odin
//
//  Created by etudiant on 25/05/2023.
//

import Foundation

struct Bloc : Identifiable, Hashable, CustomStringConvertible {
    public let id: UUID
    public private (set) var titleName: String
    public private (set) var teachingUnits: [TeachingUnit]
    
    public var average: Float {
        let totalCoefficient = teachingUnits.reduce(0.0) { $0 + $1.coefficient }
        let weightedGrades = teachingUnits.reduce(0.0) { $0 + $1.average * $1.coefficient }
        return weightedGrades / totalCoefficient
    }
    
    public var description: String {
        "[\(id)] \(titleName) - \(average)\n"
    }
    
    public init(withId id: UUID, andTitle titleName: String, andTeachingUnits teachingUnits: [TeachingUnit]) {
        self.id = id
        self.titleName = titleName
        self.teachingUnits = teachingUnits
    }
    
    public init(andTitle titleName: String, andTeachingUnits teachingUnits: [TeachingUnit]) {
        id = UUID()
        self.titleName = titleName
        self.teachingUnits = teachingUnits
    }
    
    public static func == (lhs: Bloc, rhs: Bloc) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
