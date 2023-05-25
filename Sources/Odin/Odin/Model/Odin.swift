//
//  Blocs.swift
//  Odin
//
//  Created by etudiant on 25/05/2023.
//

import Foundation

struct Odin : Identifiable, Hashable, CustomStringConvertible {
    public let id: UUID
    public private (set) var blocs: [Bloc]
    public private (set) var teachingUnits: [TeachingUnit]
    
    public var description: String {
        var name: String = "Blocs: \n"
        for bloc in blocs {
            name.append(bloc.description)
        }
        name.append("Teaching Units: \n")
        for unit in teachingUnits {
            name.append(unit.description)
        }
        return name
    }
    
    public init(withId id: UUID, andBlocs blocs: [Bloc], andUnits teachingUnits: [TeachingUnit]) {
        self.id = id
        self.blocs = blocs
        self.teachingUnits = teachingUnits
    }
    
    public init(andBlocs blocs: [Bloc], andUnits teachingUnits: [TeachingUnit]) {
        id = UUID()
        self.blocs = blocs
        self.teachingUnits = teachingUnits
    }
    
    public static func == (lhs: Odin, rhs: Odin) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
