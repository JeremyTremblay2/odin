//
//  BlocsView.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import SwiftUI
import Model

public struct BlocsView: View {
    @ObservedObject var odinVM: OdinVM
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                Image(systemName: "doc.on.doc.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .padding(.bottom, 4)
                
                Text("Détail des notes")
                    .font(.title)
            }
            .padding(.bottom, 4)
            Text("Vous devez avoir la moyenne à chacun de ces blocs pour avoir votre diplôme.")
                .padding(.bottom, 12)
            ForEach($odinVM.blocsVM) { $bloc in
                BlocView(blocVM: bloc)
                    .padding(.bottom, 4)
            }
        }
        .padding(20)
        .background(.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct BlocsView_Previews: PreviewProvider {
    static var previews: some View {
        BlocsView(odinVM: OdinVM(withPersistenceStrategy: JsonPersistenceStrategy()))
    }
}
