//
//  NotesListView.swift
//  Notes
//
//  Created by labuser on 06/08/25.
//

import SwiftUI

struct NotesListView: View {
    
    @State private var notes: [NoteViewModel] = []
    
    var body: some View {
        NavigationView {
            List(notes) { note in
                NavigationLink(note.title) {
                    NoteEditorView(notes: note)
                }
            }.navigationTitle("My Notes")
                .toolbar {
                    Button("Add") {
                        let note = NoteViewModel(title: "New Note")
                        notes.append(note)
                        
                        let context = PersistenceController.shared.container.viewContext
                        let noteDBObj = NotesTable(context: context)
                        noteDBObj.id = UUID()
                        noteDBObj.title = note.title
//                        noteDBObj.desc  = note.getText().prefix(20)
                        if context.hasChanges {
                            try? context.save()
                        }
                        
                    }
                }
        }
    }
}

struct NotesListView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView()
    }
}
