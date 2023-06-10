//
//  OdinApp.swift
//  Odin
//
//  Created by etudiant on 25/05/2023.
//

import SwiftUI
import Model

@main
struct OdinApp: App {
    @StateObject
    var odinVM: OdinVM = OdinVM(withPersistenceStrategy: JsonPersistenceStrategy())
    
    var body: some Scene {
        WindowGroup {
            CalculatorView(odinVM: odinVM) {
                Task {
                    do {
                        try await odinVM.save()
                    }
                    catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    try await odinVM.load()
                }
                catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
