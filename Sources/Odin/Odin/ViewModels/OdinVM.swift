//
//  OdinVM.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import Model

class OdinVM : ObservableObject, Identifiable, Equatable, Hashable {
    private let persistenceStrategy: PersistenceStrategy
    
    @Published var teachingUnitsVM: [TeachingUnitVM] {
        willSet(newValue) {
            newValue.forEach { vm in
                self.teachingUnitsVM.forEach { $0.unsubscribe(with: self) }
            }
        }
        didSet {
//            let teachingUnitIDs = Set(teachingUnitsVM.map { $0.model.id })
//
//            for blocVM in blocsVM {
//                var updatedTeachingUnits: [TeachingUnitVM] = []
//
//                for teachingUnitVM in blocVM.teachingUnitsVM {
//                    if teachingUnitIDs.contains(teachingUnitVM.model.id) {
//                        if let matchingTeachingUnitVM = teachingUnitsVM.first(where: { $0.model.id == teachingUnitVM.model.id }) {
//                            updatedTeachingUnits.append(matchingTeachingUnitVM)
//                        }
//                    } else {
//                        updatedTeachingUnits.append(teachingUnitVM)
//                    }
//                }
//
//                blocVM.teachingUnitsVM = updatedTeachingUnits
//            }
            self.teachingUnitsVM.forEach { vm in
                vm.subscribe(with: self, and: onNotifyChanged(source:))
            }
        }
    }
    
    @Published var blocsVM: [BlocVM]
    
    public init(withPersistenceStrategy strategy: PersistenceStrategy) {
        self.persistenceStrategy = strategy
        teachingUnitsVM = []
        blocsVM = []
    }
    
    static func == (lhs: OdinVM, rhs: OdinVM) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("odin")
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
        self.objectWillChange.send()
    }
    
    func onNotifyChanged(source: TeachingUnitVM) {
        for blocVM in blocsVM {
            blocVM.updateBloc(withTeachingUnitVM: source)
        }
        self.objectWillChange.send()
    }
}
