//
//  ViewWithLockView.swift
//  Odin
//
//  Created by etudiant on 21/06/2023.
//

import Foundation
import SwiftUI
import Model

public struct ViewWithLockView: View {
    @Binding var subjectVM: SubjectVM
    
    public var body: some View {
        Button(action: {
            subjectVM.isEditing ? subjectVM.onEdited() : subjectVM.onEditing()
        }) {
            if subjectVM.isEditing {
                Image(systemName: "lock.open.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .foregroundColor(.blue)
                    .padding(.leading, 16)
                    .padding(.trailing, 24)
            }
            else {
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16)
                    .foregroundColor(.blue)
                    .padding(.leading, 16)
                    .padding(.trailing, 24)
            }
        }
        ViewWithLineView(view : SubjectView(subject: subjectVM))
    }
}

struct ViewWithLockView_Previews: PreviewProvider {
    static var previews: some View {
        ViewWithLockView(subjectVM: .constant(SubjectVM(withSubject: generateOdin().teachingUnits.first!.subjects.first!)))
    }
}
