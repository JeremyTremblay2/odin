//
//  PersistenceStrategy.swift
//  Odin
//
//  Created by etudiant on 10/06/2023.
//

import Foundation

protocol PersistenceStrategy {
    func save(data: PersistenceData) async throws
    func load() async throws -> PersistenceData
}
