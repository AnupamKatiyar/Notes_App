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
        
        ZStack {
            // Background layer that detects taps
            Color.clear
                .contentShape(Rectangle()) // makes entire area tappable
                .onTapGesture {
                    // Dismiss keyboard on tap outside
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            VStack {
                RopeTextView(note: notes)
                    .border(.gray)
                    .padding()
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
