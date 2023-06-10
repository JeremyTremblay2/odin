//
//  SubjectVM.swift
//  Odin
//
//  Created by etudiant on 26/05/2023.
//

import Foundation
import Model

/*extension Subject {
    struct Data: Identifiable {
        public let id: UUID
        public var titleName: String
        public var coefficient: Float
        public var average: Float?
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
}*/

class SubjectVM : ObservableObject, Identifiable, Equatable {
    init() {}
    
    init(withSubject subject: Subject) {
        self.model = subject
    }
    
    @Published var model: Subject = Subject(withId: UUID(), andName: "Matière", andCoeff: 1) {
        didSet {
            if self.model.titleName != self.titleName {
                self.titleName = self.model.titleName
            }
            if self.model.coefficient != self.coefficient {
                self.coefficient = self.model.coefficient
            }
            if self.model.average != self.average {
                self.average = self.model.average
            }
        }
    }
    
    @Published var titleName: String = "" {
        didSet {
            if self.model.titleName != self.titleName {
                self.model.titleName = self.titleName
            }
        }
    }
    
    @Published var coefficient: Float = 0 {
        didSet {
            if self.model.coefficient != self.coefficient {
                self.model.coefficient = self.coefficient
            }
        }
    }
    
    @Published var average: Float? = nil {
        didSet {
            if self.model.average != self.average {
                self.model.average = self.average
            }
        }
    }
    
    public var id: UUID { model.id }
    
    @Published var isEditing: Bool = false
    private var copy: SubjectVM { SubjectVM(withSubject: self.model) }
    var editedCopy: SubjectVM?
    
    static func == (lhs: SubjectVM, rhs: SubjectVM) -> Bool {
        lhs.id == rhs.id
    }

    func onEditing(){
        editedCopy = self.copy
        isEditing = true
    }
        
    func onEdited(isCancelled cancel: Bool = false) {
        if !cancel {
            if let editedCopy = editedCopy {
                self.model = editedCopy.model
            }
        }
        editedCopy = nil
        isEditing = false
    }
}
