//
//  NoteViewModel.swift
//  Notes
//
//  Created by Anupam Katiyar on 05/08/25.
//

import Foundation

class NoteViewModel: Identifiable, ObservableObject {
    
    @Published var title: String
    private var note: Rope
    private var noteObject: NotesTable

    init(_ noteObject: NotesTable) {
        self.noteObject = noteObject
        
        self.title = noteObject.title ?? ""
        self.note  = Rope(text: noteObject.desc ?? "")
    }
    
    func getText() -> String {
        return note.getText()
    }

    func replaceText(in range: NSRange, with text: String) {
        let start = range.location
        let end   = range.location + range.length
        
        if range.length > 0 {
            self.note.delete(range: start..<end)
        }
        if !text.isEmpty {
            self.note.insert(text, at: start)
        }
    }
    
    func saveNote() {
        noteObject.title = title
        noteObject.desc  = getText()
        
        noteObject.updatedAt = Date()
        
        try? PersistenceController.shared.container.viewContext.save()
    }
}
