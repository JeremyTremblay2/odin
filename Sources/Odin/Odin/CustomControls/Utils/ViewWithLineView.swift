//
//  SubjectViewWithLine.swift
//  Odin
//
//  Created by etudiant on 28/05/2023.
//

import Foundation
import SwiftUI
import Model

public struct ViewWithLineView<Content: View>: View {
    var view: Content
    
    public var body: some View {
        VStack(spacing: 0) {
            view
            Divider()
                .frame(height: 1)
                .overlay(.gray)
                .padding(.top, 12)
        }
    }
}
struct ViewWithLineView_Previews: PreviewProvider {
    static var previews: some View {
        ViewWithLineView(view: Text("toto"))
    }
}
