//
//  Subject.swift
//  Odin
//
//  Created by etudiant on 25/05/2023.
//

import Foundation

public struct Subject : Identifiable, Hashable, CustomStringConvertible, Codable {
    public let id: UUID
    public var titleName: String
    public var coefficient: Float
    public var average: Float?
    
    public var description: String {
        "[\(id)] \(titleName) - \(average != nil ? String(average!) : "No notes") [Coeff: \(coefficient)]\n"
    }
    
    public init(withId id: UUID, andName titleName: String, andCoeff coefficient: Float, andAverage average: Float? = nil) {
        self.id = id
        self.titleName = titleName
        self.coefficient = coefficient
        self.average = average
    }
    
    public init(withName titleName: String, andCoeff coefficient: Float, andAverage average: Float? = nil) {
        self.id = UUID()
        self.titleName = titleName
        self.coefficient = coefficient
        self.average = average
    }
    
    public static func == (lhs: Subject, rhs: Subject) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
