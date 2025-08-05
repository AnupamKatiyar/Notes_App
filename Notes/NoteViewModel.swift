//
//  NoteViewModel.swift
//  Notes
//
//  Created by Anupam Katiyar on 05/08/25.
//

import Foundation

class NoteViewModel: ObservableObject {
    
    private var note: Rope
    
    @Published var content: String
    
    init(text: String) {
        self.note = Rope(text: text)
        content = text
    }
    
    func insert(_ text: String, at index: Int) {
        note.insert(text, at: index)
        content = note.getText()
    }
    
    func delete(range: Range<Int>) {
        note.delete(range: range)
        content = note.getText()
    }
    
}
