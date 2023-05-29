//
//  TeachinUnitViews.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import SwiftUI
import Model

public struct TeachingUnitsView: View {
    @ObservedObject var odinVM: OdinVM
    
    public var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "doc.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .padding(.bottom, 4)
                    
                    Text("UEs")
                        .font(.title)
                }
                Text("Détail des UEs.")
                    .padding(.bottom, 20)
                
                ForEach(odinVM.teachingUnits) { unit in
                    HStack(alignment: .center, spacing: 0) {
                        ViewWithLineView(view: TeachingUnitView(teachingUnit: TeachingUnitVM(withTeachingUnit: unit)))
                        NavigationLink(destination: TeachingUnitDetailView(odinVM: odinVM, teachingUnitVM: TeachingUnitVM(withTeachingUnit: unit))) {
                            Image(systemName: "square.and.pencil")
                                .padding(.leading, 8)
                                .padding(.trailing, 16)
                        }
                    }
                    .padding(.bottom, 12)
                    
                }
            }
            .padding(20)
            .background(.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

struct TeachingUnitsView_Previews: PreviewProvider {
    static var previews: some View {
        TeachingUnitsView(odinVM: OdinVM(withTeachingUnits: generateOdin().teachingUnits, withBlocs: generateOdin().blocs))
    }
}
