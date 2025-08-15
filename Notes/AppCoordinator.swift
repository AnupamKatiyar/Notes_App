//
//  AppCoordinator.swift
//  Notes
//
//  Created by Udit Kalra on 16/08/25.
//
import SwiftUI

enum NavigationPath: Hashable {
    case editor(NotesTable)
}

// MARK: - Coordinator Protocol
protocol AppCoordinatorProtocol: ObservableObject {
    func createView(for path: NavigationPath) -> AnyView
}

class AppCoordinator: AppCoordinatorProtocol {
    
    func createView(for path: NavigationPath) -> AnyView {
        switch path {
        case .editor(let noteObj):
            let vm = NoteViewModel(noteObj)
            return AnyView(NoteEditorView(coordinator: self).environmentObject(vm))
        }
    }
    
}
