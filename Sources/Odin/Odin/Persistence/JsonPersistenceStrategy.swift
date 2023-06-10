//
//  JsonPersistenceStrategy.swift
//  Odin
//
//  Created by etudiant on 10/06/2023.
//

import Foundation
import Model

public class JsonPersistenceStrategy : PersistenceStrategy {
    private let filename = "odin.data"
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                       .appendingPathComponent("scrums.data")
    }
    
    func save(data: PersistenceData) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(data)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        try await task.value
    }

    func load() async throws -> PersistenceData {
        let task = Task<PersistenceData, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return PersistenceData(teachingUnits: [], blocs: [])
            }
            
            let persistenceData = try JSONDecoder().decode(PersistenceData.self, from: data)
            return persistenceData
        }
        
        var persistenceData: PersistenceData
        
        do {
            persistenceData = try await task.value
        }
        catch {
            persistenceData = PersistenceData(teachingUnits: generateOdin().teachingUnits, blocs: generateOdin().blocs)
        }
        
        if persistenceData.blocs.isEmpty || persistenceData.teachingUnits.isEmpty {
            persistenceData = PersistenceData(teachingUnits: generateOdin().teachingUnits, blocs: generateOdin().blocs)
        }
        return persistenceData
    }
}
