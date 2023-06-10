//
//  CalculatorView.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import SwiftUI
import Model

struct CalculatorView: View {
    @ObservedObject var odinVM: OdinVM
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    BlocsView(odinVM: odinVM)
                        .padding(.top, 10)
                        .padding(.horizontal, 6)
                    
                    Divider()
                        .frame(height: 1)
                        .overlay(.gray)
                        .padding(.vertical, 16)
                        
                    TeachingUnitsView(odinVM: odinVM)
                        .padding(.horizontal, 6)
                }
                .navigationTitle("Calculette")
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(odinVM: OdinVM(withPersistenceStrategy: JsonPersistenceStrategy()), saveAction: {})
    }
}
