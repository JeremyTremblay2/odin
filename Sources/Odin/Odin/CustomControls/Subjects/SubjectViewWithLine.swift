//
//  SubjectViewWithLine.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import SwiftUI
import Model

public struct SubjectWithLineView: View {
    @ObservedObject var subject: SubjectVM
    
    public var body: some View {
        VStack(spacing: 0) {
            SubjectView(subject: subject)
            Divider()
                .frame(height: 1)
                .overlay(.gray)
                .padding(.top, 12)
        }
    }
}
struct SubjectWithLineView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectWithLineView(subject: SubjectVM(withSubject: generateOdin().teachingUnits.first!.subjects.first!))
    }
}
