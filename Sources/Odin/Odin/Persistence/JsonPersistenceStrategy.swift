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
    
    public func save(withTeachingUnits teachingUnits: [TeachingUnit], withBlocs blocs: [Bloc]) async throws {
        let data = PersistenceData(teachingUnits: teachingUnits, blocs: blocs)
        let task = Task {
            let data = try JSONEncoder().encode(data)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        try await task.value
    }

    public func load() async throws -> ([TeachingUnit], [Bloc]) {
        let task = Task<PersistenceData, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return PersistenceData(teachingUnits: [], blocs: [])
            }
            
            let persistenceData = try JSONDecoder().decode(PersistenceData.self, from: data)
            return persistenceData
        }
        
        var persistenceData: PersistenceData
        let odin = generateOdin()
        
        do {
            persistenceData = try await task.value
        }
        catch {
            persistenceData = PersistenceData(teachingUnits: odin.teachingUnits, blocs: odin.blocs)
        }
        
        if persistenceData.blocs.isEmpty || persistenceData.teachingUnits.isEmpty {
            persistenceData = PersistenceData(teachingUnits: odin.teachingUnits, blocs: odin.blocs)
        }
        return (persistenceData.teachingUnits, persistenceData.blocs)
    }
}
