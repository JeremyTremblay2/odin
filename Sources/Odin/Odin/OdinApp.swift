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
    var odinVM: OdinVM = OdinVM(withTeachingUnits: generateOdin().teachingUnits, withBlocs: generateOdin().blocs)
    
    var body: some Scene {
        WindowGroup {
            CalculatorView(odinVM: odinVM)
        }
    }
}
