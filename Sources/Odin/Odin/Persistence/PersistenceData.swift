//
//  PersistenceData.swift
//  Odin
//
//  Created by etudiant on 10/06/2023.
//

import Foundation
import Model

struct PersistenceData: Codable {
    let teachingUnits: [TeachingUnit]
    let blocs: [Bloc]
}
