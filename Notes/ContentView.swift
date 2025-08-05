//
//  ContentView.swift
//  Notes
//
//  Created by Anupam Katiyar on 05/08/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var notes = NoteViewModel(text: "Hi There")
    
    var body: some View {
        VStack {
            TextEditor(text: $notes.content)
                .border(.gray)
                .padding()
            
            HStack {
                Button("Insert Text") {
                    notes.insert("Anupam Katiyar", at: (1...10).randomElement()!)
                }.padding()
                Button("Delete Text") {
                    notes.delete(range: 2..<6)
                }.padding()
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
