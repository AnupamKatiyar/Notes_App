//
//  RopeNode.swift
//  Notes
//
//  Created by Anupam Katiyar on 05/08/25.
//

import Foundation

class RopeNode {
    
    var left: RopeNode?
    var right: RopeNode?
    var text: String
    var weight: Int
    
    init(text: String) {
        self.text = text
        self.weight = text.count
    }
    
    init(left: RopeNode? = nil, right: RopeNode? = nil) {
        self.left = left
        self.right = right
        
        self.text = ""
        self.weight = left?.length ?? 0
    }
    
    var length: Int {
        if left == nil && right == nil {
            return text.count
        } else {
            return (left?.length ?? 0) + (right?.length ?? 0)
        }
    }
    
}
