//
//  NotesListView.swift
//  Notes
//
//  Created by Anupam Katiyar on 06/08/25.
//

import SwiftUI

struct NotesListView: View {
    
    @StateObject private var notesViewModel = NoteListViewModel()
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notesViewModel.notes, id: \.id) { note in
                    NavigationLink(note.title ?? "") {
                        coordinator.createView(for: .editor(note))
                    }
                }
                .onDelete(perform: deleteNotes) //Doesn't work without foreach
            }
            .navigationTitle("My Notes")
            .toolbar {
                Button("Add") {
                    notesViewModel.addNewNote()
                }
            }
        }
    }
    
    private func deleteNotes(offsets: IndexSet) {
        notesViewModel.deleteNotes(at: offsets)
    }
}

struct NotesListView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView()
    }
}
