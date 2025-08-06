//
//  RopeTextView.swift
//  Notes
//
//  Created by Anupam Katiyar on 06/08/25.
//

import SwiftUI

struct RopeTextView: UIViewRepresentable {
    typealias UIViewType = UITextView
        
    @ObservedObject var note: NoteViewModel
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.text = note.getText()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = context.coordinator
        textView.isEditable = true
        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if uiView.text != note.getText() {
            uiView.text = note.getText()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(note: note)
    }
    
}

class Coordinator: NSObject, UITextViewDelegate {
    var note: NoteViewModel
    
    init(note: NoteViewModel) {
        self.note = note
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        note.replaceText(in: range, with: text)
        return true
    }
}
