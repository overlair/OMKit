//
//  File.swift
//  
//
//  Created by John Knowles on 7/28/24.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Collection {
    var isntEmpty: Bool {
        !isEmpty
    }
}


extension Array {
    
    @discardableResult
    mutating func pop() -> Array.Element? {
        self.popLast()
    }
}



extension Set {
    mutating func toggle(_ element: Set.Element) {
        if self.contains(element) {
            self.remove(element)
        } else {
            self.insert(element)
        }
    }
}

