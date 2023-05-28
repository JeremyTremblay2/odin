//
//  BlocView.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import SwiftUI
import Model

public struct BlocView: View {
    var bloc: Bloc
    
    private var averageValue: String {
        bloc.average == nil ? "-" : String(format: "%.2f", bloc.average!)
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "doc.on.doc.fill")
                    .padding(.trailing, 10)
                Text(bloc.titleName)
                Spacer()
                Text(averageValue)
                    .padding(.horizontal, 10)
                Image(systemName: "graduationcap.circle.fill")
            }
        }
    }
}

struct BlocView_Previews: PreviewProvider {
    static var previews: some View {
        BlocView(bloc: generateOdin().blocs.first!)
    }
}
