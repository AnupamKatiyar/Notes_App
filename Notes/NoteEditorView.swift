//
//  NoteEditorView.swift
//  Notes
//
//  Created by Anupam Katiyar on 05/08/25.
//

import SwiftUI

struct NoteEditorView: View {
    
    @ObservedObject var coordinator: AppCoordinator
    @EnvironmentObject var noteViewModel: NoteViewModel

    @Environment(\.presentationMode) var presentationMode

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
                TextEditor(text: $noteViewModel.title)
                    .border(.gray)
                    .cornerRadius(5)
                    .frame(height: 40)
                RopeTextView(note: noteViewModel)
                    .border(.gray)
                HStack {
                    Button("Save") {
                        //Save logic to db or auto save will also work
                        noteViewModel.saveNote()
                        
                        NotificationCenter.default.post(
                            name: .noteDidUpdate,
                            object: nil
                        )
                        presentationMode.wrappedValue.dismiss()
//                        coordinator.dismiss()
                    }
                }
            }
            .padding()
        }
        .navigationTitle($noteViewModel.title).navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let t = NotesTable(context: PersistenceController.shared.container.viewContext)
        NoteEditorView(coordinator: AppCoordinator())
            .environmentObject(NoteViewModel(t))
    }
}
