//
//  ContentView.swift
//  Odin
//
//  Created by etudiant on 25/05/2023.
//

import SwiftUI

struct ContentView: View {
    @State var average: Float = 20
    var body: some View {
        VStack {
            Text("Calculette \(average)")
            CapsuleSlider(average: $average, minValue: 10, maxValue: 30, height: 20)
                .padding(.horizontal, 40)
        }
        .navigationTitle("Calculette")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
