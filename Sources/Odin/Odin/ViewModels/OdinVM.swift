//
//  OdinVM.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import Model

class OdinVM : ObservableObject, Identifiable, Equatable {
    private let persistenceStrategy: PersistenceStrategy
    
    @Published var teachingUnitsVM: [TeachingUnitVM]
    @Published var blocsVM: [BlocVM]
    
    public init(withPersistenceStrategy strategy: PersistenceStrategy) {
        self.persistenceStrategy = strategy
        teachingUnitsVM = []
        blocsVM = []
    }
    
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
    
    public func save() async throws {
        try await persistenceStrategy.save(withTeachingUnits: teachingUnitsVM.map { $0.model }, withBlocs: blocsVM.map { $0.model })
    }

    public func load() async throws {
        let data = try await persistenceStrategy.load()
        self.teachingUnitsVM = data.0.map { TeachingUnitVM(withTeachingUnit: $0) }
        self.blocsVM = data.1.map { BlocVM(withBloc: $0) }
    }
}
