//
//  NoteEditorView.swift
//  Notes
//
//  Created by Anupam Katiyar on 05/08/25.
//

import SwiftUI

struct NoteEditorView: View {
    
    @ObservedObject var notes: NoteViewModel
    
    var body: some View {
//
//        ZStack {
//            // Background layer that detects taps
//            Color.clear
//                .contentShape(Rectangle()) // makes entire area tappable
//                .onTapGesture {
//                    // Dismiss keyboard on tap outside
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                }
            VStack {
                TextEditor(text: $notes.title)
                    .border(.gray)
                    .cornerRadius(5)
                    .frame(height: 40)
                RopeTextView(note: notes)
                    .border(.gray)
                HStack {
                    Button("Save") {
                        //Save logic to db or auto save will also work
                    }
                }
            }
            .padding()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditorView(notes: NoteViewModel(title: "Hi"))
    }
}
