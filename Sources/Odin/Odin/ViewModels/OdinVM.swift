//
//  OdinVM.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import Model

class OdinVM : ObservableObject, Identifiable, Equatable {
    private let persistenceStrategy: PersistenceStrategy = JsonPersistenceStrategy()
    
    @Published var teachingUnitsVM: [TeachingUnitVM]
    @Published var blocsVM: [BlocVM]
    
    public init(withTeachingUnits teachingUnits: [TeachingUnitVM], withBlocs blocs: [BlocVM]) {
        self.teachingUnitsVM = teachingUnits
        self.blocsVM = blocs
    }
        
    public init(withTeachingUnits teachingUnits: [TeachingUnit], withBlocs blocs: [Bloc]) {
        self.teachingUnitsVM = teachingUnits.map({ TeachingUnitVM(withTeachingUnit: $0) })
        self.blocsVM = blocs.map({ BlocVM(withBloc: $0) })
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
        try await persistenceStrategy.save(data: PersistenceData(teachingUnits: teachingUnitsVM.map { $0.model }, blocs: blocsVM.map { $0.model }))
    }

    public func load() async throws {
        let data = try await persistenceStrategy.load()
        self.teachingUnitsVM = data.teachingUnits.map { TeachingUnitVM(withTeachingUnit: $0) }
        self.blocsVM = data.blocs.map { BlocVM(withBloc: $0) }
    }
}
