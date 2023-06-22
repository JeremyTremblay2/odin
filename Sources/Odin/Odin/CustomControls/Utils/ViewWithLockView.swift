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
    @ObservedObject var subjectVM: SubjectVM
    
    var image: some View {
        if subjectVM.isEditing {
            return Image(systemName: "lock.open.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 24)
                .foregroundColor(.blue)
                .padding(.leading, 16)
                .padding(.trailing, 24)
        }
        else {
            return Image(systemName: "lock.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 16)
                .foregroundColor(.blue)
                .padding(.leading, 16)
                .padding(.trailing, 24)
        }
    }
    
    public var body: some View {
        Button(action: {
            subjectVM.isEditing ? subjectVM.onEdited() : subjectVM.onEditing()
        }) {
            image
        }
        ViewWithLineView(view : SubjectView(subject: subjectVM))
    }
}

//struct ViewWithLockView_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewWithLockView(subjectVM: SubjectVM(withSubject: generateOdin().teachingUnits.first!.subjects.first!))
//    }
//}
