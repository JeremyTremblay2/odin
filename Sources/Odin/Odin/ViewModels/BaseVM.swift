//
//  BaseVM.swift
//  Odin
//
//  Created by etudiant on 02/06/2023.
//

import Foundation

public class BaseVM {
    var callbacks: [(BaseVM) -> ()]
    
    init(callbacks: [ (BaseVM) -> Void]) {
        self.callbacks = callbacks
    }
    
    public func notify() {
        for callback in callbacks {
            callback(self)
        }
    }
}
