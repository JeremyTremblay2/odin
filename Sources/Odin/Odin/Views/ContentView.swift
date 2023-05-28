//
//  ContentView.swift
//  Odin
//
//  Created by etudiant on 25/05/2023.
//

import SwiftUI
import Model

struct ContentView: View {
    var odinVM: OdinVM = OdinVM(withTeachingUnits: generateOdin().teachingUnits, withBlocs: generateOdin().blocs)
    
    var body: some View {
        VStack {
            CalculatorView(odinVM: odinVM)
        }
        .navigationTitle("Calculette")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
