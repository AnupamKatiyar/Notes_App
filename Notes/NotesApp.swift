//
//  NotesApp.swift
//  Notes
//
//  Created by Anupam Katiyar on 05/08/25.
//

import SwiftUI

@main
struct NotesApp: App {
    var body: some Scene {
        WindowGroup {
            NotesListView(NoteListViewModel())
        }
    }
}
