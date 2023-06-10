//
//  PersistenceStrategy.swift
//  Odin
//
//  Created by etudiant on 10/06/2023.
//

import Foundation
import Model

public protocol PersistenceStrategy {
    func save(withTeachingUnits teachingUnits: [TeachingUnit], withBlocs blocs: [Bloc]) async throws
    func load() async throws -> ([TeachingUnit], [Bloc])
}
