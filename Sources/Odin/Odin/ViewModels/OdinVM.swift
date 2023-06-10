//
//  OdinVM.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import Model

class OdinVM : ObservableObject, Identifiable, Equatable {
    private static let filename = "odin.data"
    
    public init(withTeachingUnits teachingUnits: [TeachingUnitVM], withBlocs blocs: [BlocVM]) {
        self.teachingUnitsVM = teachingUnits
        self.blocsVM = blocs
    }
        
    public init(withTeachingUnits teachingUnits: [TeachingUnit], withBlocs blocs: [Bloc]) {
        self.teachingUnitsVM = teachingUnits.map({ TeachingUnitVM(withTeachingUnit: $0) })
        self.blocsVM = blocs.map({ BlocVM(withBloc: $0) })
    }
    
    @Published var teachingUnitsVM: [TeachingUnitVM]
        
    @Published var blocsVM: [BlocVM]
    
    static func == (lhs: OdinVM, rhs: OdinVM) -> Bool {
        lhs.id == rhs.id
    }
    
    func update(withTeachingUnitVM teachingUnitVM: TeachingUnitVM) {
        /*if let i = teachingUnits.firstIndex(where: { $0.id == teachingUnitVM.original.id}) {
            teachingUnits[i] = teachingUnitVM.original
        }
        else {
            teachingUnits.append(teachingUnitVM.original)
        }*/
    }
    
    func remove(withTeachingUnitVM teachingUnitVM: TeachingUnitVM) {
        //if let i = teachingUnits.firstIndex(where: { $0.id == teachingUnitVM.original.id}) {
        //    teachingUnits.remove(at: i)
        //}
    }

    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                       .appendingPathComponent(filename)
    }

    func load() async throws {
        let task = Task<[TeachingUnit], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }

            let teachingUnits = try JSONDecoder().decode([TeachingUnit].self, from: data)
            return teachingUnits
        }

        let teachingUnits = try await task.value
        if (teachingUnits.count == 0) {
            self.teachingUnitsVM = generateOdin().teachingUnits.map({ TeachingUnitVM(withTeachingUnit: $0) })
        }
        else {
            self.teachingUnitsVM = teachingUnits.map({ TeachingUnitVM(withTeachingUnit: $0) })
        }
    }

    func save() async throws {
        let task = Task {
            let data = try JSONEncoder().encode(teachingUnitsVM.map({ $0.model }))
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
