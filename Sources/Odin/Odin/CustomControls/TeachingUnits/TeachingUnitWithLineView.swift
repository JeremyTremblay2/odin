//
//  TeachingUnitWithLineView.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import SwiftUI
import Model

public struct TeachingUnitWithLineView: View {
    @ObservedObject var teachingUnit: TeachingUnitVM
    
    public var body: some View {
        VStack(spacing: 0) {
            TeachingUnitView(teachingUnit: teachingUnit)
            Divider()
                .frame(height: 1)
                .overlay(.gray)
                .padding(.top, 12)
        }
    }
}
struct TeachingUnitWithLineView_Previews: PreviewProvider {
    static var previews: some View {
        TeachingUnitWithLineView(teachingUnit: TeachingUnitVM(withTeachingUnit: generateOdin().teachingUnits.first!))
    }
}
