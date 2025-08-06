//
//  NoteFileManager.swift
//  Notes
//
//  Created by Anupam Katiyar on 06/08/25.
//

import Foundation

class NoteFileManager {
    
    static let shared = NoteFileManager()
    private let noteDirectory: URL
    
    private init() {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        noteDirectory = documentURL.appendingPathComponent("Notes")
        try? FileManager.default.createDirectory(at: noteDirectory, withIntermediateDirectories: true)
    }
    
    func save(content: String, for note: NotesTable) throws {
        let fileURL = noteDirectory.appendingPathComponent("\(String(describing: note.id)).txt")
        try content.write(to: fileURL, atomically: true, encoding: .utf8)
        note.filePath = fileURL.path
    }
    
    func load(note: NotesTable) -> String? {
        guard let path = note.filePath,
                FileManager.default.fileExists(atPath: path) else { return nil }
        return try? String(contentsOfFile: path)
    }
    
    func delete(note: NotesTable) {
        guard let path = note.filePath else { return }
        try? FileManager.default.removeItem(atPath: path)
    }
    
}
