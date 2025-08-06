//
//  Rope.swift
//  Notes
//
//  Created by Anupam Katiyar on 05/08/25.
//

import Foundation

class Rope {
    
    private var rootNode: RopeNode?
    
    init(text: String) {
        self.rootNode = RopeNode(text: text)
    }
    
    func insert(_ str: String, at index: Int) {
        let (left, right) = split(rootNode, index)
        
        let mid = RopeNode(text: str)
        rootNode = concatenate(concatenate(left, mid), right)
    }

    func delete(range: Range<Int>) {
        let (left, rest) = split(rootNode, range.lowerBound)
        let (_, right) = split(rest, range.upperBound - range.lowerBound)
        
        rootNode = concatenate(left, right)
    }

    func getText() -> String {
        return collectText(rootNode)
    }
    
    private func split(_ node: RopeNode?, _ index: Int) -> (RopeNode?, RopeNode?) {
        
        guard let node = node else {   return (nil, nil)  }
        
        if node.left == nil && node.right == nil {
            let left = String(node.text.prefix(index))
            let right = String(node.text.suffix(abs(node.text.count - index)))
            
            return (RopeNode(text: left), RopeNode(text: right))
        }
        
        if index < (node.left?.length ?? 0) {
            let (left, right) = split(node.left, index)
            return (left, concatenate(right, node.right))
            
        } else {
            let (left, right) = split(node.right, index - (node.left?.length ?? 0))
            return (concatenate(node.left, left), right)
        }
        
    }
    
    private func concatenate(_ left: RopeNode?, _ right: RopeNode?) -> RopeNode? {
        
        if left == nil { return right }
        if right == nil { return left }
        
        return RopeNode(left: left, right: right)
    }
    
    private func collectText(_ node: RopeNode?) -> String {
        guard let node = node else { return "" }
        
        if node.left == nil && node.right == nil {
            return node.text
        }
        
        return collectText(node.left) + collectText(node.right)
    }
    
}
