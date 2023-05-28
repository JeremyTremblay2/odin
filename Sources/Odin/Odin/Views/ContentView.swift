//
//  ContentView.swift
//  Odin
//
//  Created by etudiant on 25/05/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NoteDetailView()
        }
        .navigationTitle("Calculette")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
