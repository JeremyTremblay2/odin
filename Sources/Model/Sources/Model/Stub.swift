//
//  Stub.swift
//  Odin
//
//  Created by etudiant on 25/05/2023.
//

import Foundation

public struct Stub {
    var odin: Odin?
    
    mutating func generateOdin() -> Odin {
        guard odin == nil else {
            return odin!
        }
        
        let subject1 = Subject(withName: "Processus de développements", andCoeff: "109.00", andAverage: 14.46)
        let subject2 = Subject(withName: "Programmation Objets", andCoeff: "246.00", andAverage: 19.43)
        let subject3 = Subject(withName: "Qualité de développement", andCoeff: "136.00", andAverage: 15.2)
        let subject4 = Subject(withName: "Remise à niveau Objets", andCoeff: "109.00", andAverage: 18.0)
        let teachingUnit1 = TeachingUnit(withName: "Génie logiciel", andUnitNumber: 1, andCoeff: 6.0, andSubjects: [subject1, subject2, subject3, subject4])
        
        // Subjects for UE 2: Systèmes et Réseaux
        let subject5 = Subject(withName: "Internet des Objets", andCoeff: "141.00")
        let subject6 = Subject(withName: "Réseaux", andCoeff: "141.00", andAverage: 12.0)
        let subject7 = Subject(withName: "Services Mobiles", andCoeff: "141.00")
        let subject8 = Subject(withName: "Système", andCoeff: "177.00", andAverage: 14.5)
        let teachingUnit2 = TeachingUnit(withName: "Systèmes et Réseaux", andUnitNumber: 2, andCoeff: 6.0, andSubjects: [subject5, subject6, subject7, subject8])
        
        // Subjects for UE 3: Insertion professionnelle
        let subject9 = Subject(withName: "Anglais", andCoeff: "187.50", andAverage: 14.2)
        let subject10 = Subject(withName: "Communication", andCoeff: "150.00", andAverage: 19.0)
        let subject11 = Subject(withName: "Economie", andCoeff: "150.00")
        let subject12 = Subject(withName: "Gestion", andCoeff: "112.50")
        let teachingUnit3 = TeachingUnit(withName: "Insertion professionnelle", andUnitNumber: 3, andCoeff: 6.0, andSubjects: [subject9, subject10, subject11, subject12])
        
        // Subjects for UE 4: Technologies Mobiles 1
        let subject13 = Subject(withName: "Android", andCoeff: "270.00", andAverage: 19.0)
        let subject14 = Subject(withName: "Architecture de projets C# .NET (1)", andCoeff: "225.00", andAverage: 18.0)
        let subject15 = Subject(withName: "C++", andCoeff: "180.00", andAverage: 16.0)
        let subject16 = Subject(withName: "Swift", andCoeff: "225.00", andAverage: 17.23)
        let teachingUnit4 = TeachingUnit(withName: "Technologies Mobiles 1", andUnitNumber: 4, andCoeff: 9.0, andSubjects: [subject13, subject14, subject15, subject16])
        
        // Subjects for UE 5: Technologies Mobiles 2
        let subject17 = Subject(withName: "Architecture de projets C# .NET (2)", andCoeff: "139.00", andAverage: 13.33)
        let subject18 = Subject(withName: "Client / Serveur", andCoeff: "139.00")
        let subject19 = Subject(withName: "iOS", andCoeff: "173.00")
        let subject20 = Subject(withName: "Multiplateformes", andCoeff: "103.00")
        let subject21 = Subject(withName: "QT Quick", andCoeff: "173.00")
        let subject22 = Subject(withName: "Xamarin", andCoeff: "173.00")
        let teachingUnit5 = TeachingUnit(withName: "Technologies Mobiles 2", andUnitNumber: 5, andCoeff: 9.0, andSubjects: [subject17, subject18, subject19, subject20, subject21, subject22])
        
        // Subjects for UE 6: Projet
        let subject23 = Subject(withName: "Projet", andCoeff: "900.00", andAverage: 17.69)
        let teachingUnit6 = TeachingUnit(withName: "Projet", andUnitNumber: 6, andCoeff: 9.0, andSubjects: [subject23])
        
        // Subjects for UE 7: Stage
        let subject24 = Subject(withName: "Stage", andCoeff: "1500.00")
        let teachingUnit7 = TeachingUnit(withName: "Stage", andUnitNumber: 7, andCoeff: 15.0, andSubjects: [subject24])
        
        // Create blocks
        let bloc1 = Bloc(withTitle: "Total", andTeachingUnits: [teachingUnit1, teachingUnit2, teachingUnit3, teachingUnit4, teachingUnit5, teachingUnit6, teachingUnit7])
        
        let bloc2 = Bloc(withTitle: "Projet/Stage", andTeachingUnits: [teachingUnit6, teachingUnit7])
        
        // Create Odin instance
        odin = Odin(withBlocs: [bloc1, bloc2], andUnits: [teachingUnit1, teachingUnit2, teachingUnit3, teachingUnit4, teachingUnit5, teachingUnit6, teachingUnit7])
        
        return odin!
    }
}
