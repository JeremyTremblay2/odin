//
//  StubPersistenceStrategy.swift
//  Odin
//
//  Created by etudiant on 15/06/2023.
//

import Foundation
import Model

class StubPersistenceStrategy : PersistenceStrategy {
    func save(withTeachingUnits teachingUnits: [TeachingUnit], withBlocs blocs: [Bloc]) async throws {
        
    }
    
    func load() async throws -> ([TeachingUnit], [Bloc]) {
        let odin = generateOdin()
        return (odin.teachingUnits, odin.blocs)
    }
}
