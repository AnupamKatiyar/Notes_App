//
//  NotesListView.swift
//  Notes
//
//  Created by Anupam Katiyar on 06/08/25.
//

import SwiftUI

struct NotesListView: View {
    
    @ObservedObject private var notesViewModel: NoteListViewModel
    
    init(_ viewModel: NoteListViewModel) {
        self.notesViewModel = viewModel
    }
    
    //@State private var notes: [NoteViewModel] = []
    
    var body: some View {
        NavigationView {
            List(notesViewModel.notes) { note in
                NavigationLink(note.title ?? "") {
                    let vm = NoteViewModel(note)
                    NoteEditorView(noteViewModel: vm)
                }
            }.navigationTitle("My Notes")
                .toolbar {
                    Button("Add") {
                        notesViewModel.addNewNote()
                    }
                }
        }
    }
}

struct NotesListView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView(NoteListViewModel())
    }
}
