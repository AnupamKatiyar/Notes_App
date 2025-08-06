//
//  NoteViewModel.swift
//  Notes
//
//  Created by Anupam Katiyar on 05/08/25.
//

import Foundation

class NoteViewModel: ObservableObject {
    
    private var note: Rope
        
    init(text: String) {
        self.note = Rope(text: text)
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
}
