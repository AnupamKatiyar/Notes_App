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
        self.setupNotifications()
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            forName: .noteDidUpdate,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.refreshNotes()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func deleteNotes(at offsets: IndexSet) {
        // Delete from Core Data
        for index in offsets {
            let note = notes[index]
            context.delete(note)
            notes.remove(at: index)
        }
        
        // Save changes
        do {
            try context.save()
        } catch {
            print("Failed to delete notes: \(error)")
        }
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
        request.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: false)]
        do {
            self.notes = try self.context.fetch(request)
        } catch let err {
            print("No data during fetch with err" + err.localizedDescription)
        }
        
    }
    
    func refreshNotes() {
        self.fetchNotes()
    }
    
}


extension Notification.Name {
    static let noteDidUpdate = Notification.Name("noteDidUpdate")
}
