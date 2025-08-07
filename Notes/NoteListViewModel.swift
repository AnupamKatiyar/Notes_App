//
//  NoteListViewModel.swift
//  Notes
//
//  Created by Anupam Katiyar on 07/08/25.
//

import Foundation
import CoreData

class NoteListViewModel: ObservableObject {
    
    @Published var notes: [NotesTable] = []
    
    lazy private var context: NSManagedObjectContext = {
        return PersistenceController.shared.container.viewContext
    }()
    
    init() {
        self.fetchNotes()
    }

    func addNewNote() {
        let noteDBObj = NotesTable(context: context)
        noteDBObj.id = UUID()
        noteDBObj.title = "New Note"
        // noteDBObj.desc  = note.getText().prefix(20)
        if context.hasChanges {
            try? context.save()
        }
        
        self.notes.append(noteDBObj)
    }
    
    func fetchNotes() {
        let request = NotesTable.fetchRequest()
        do {
            self.notes = try self.context.fetch(request)
        } catch let err {
            print("No data during fetch with err" + err.localizedDescription)
        }
        
    }
}
