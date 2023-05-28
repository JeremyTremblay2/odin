//
//  SubjectVM.swift
//  Odin
//
//  Created by etudiant on 26/05/2023.
//

import Foundation
import Model

extension Subject {
    struct Data: Identifiable {
        public let id: UUID
        public private (set) var titleName: String
        public private (set) var coefficient: Float
        public private (set) var average: Float?
    }
    
    var data: Data { Data(id: self.id, titleName: self.titleName, coefficient: self.coefficient, average: self.average) }
    
    mutating func update(fromData data: Data) {
        guard data.id == self.id else {
            return
        }
        self.titleName = data.titleName
        self.coefficient = data.coefficient
        self.average = data.average
    }
}

class SubjectVM : ObservableObject {
    var original: Subject
    
    @Published var model: Subject.Data = Subject.Data(id: UUID(), titleName: "", coefficient: 1)
    @Published var isEdited = false
    
    init(withSubject subject: Subject) {
        self.original = subject
        model = original.data
    }
    
    func onEditing() {
        model = original.data
        isEdited = false
    }
    
    func onEdited(isCancelled cancelled: Bool = false) {
        if (!cancelled) {
            original.update(fromData: model)
        }
        isEdited = false
    }
}
