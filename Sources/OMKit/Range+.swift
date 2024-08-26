//
//  File.swift
//  
//
//  Created by John Knowles on 7/28/24.
//

import Foundation

extension ClosedRange where Bound == Float {
    // to 0...1
    func normalize() -> (Float) -> (Float) {
        return { value in
            return (value - self.lowerBound) / (self.upperBound - self.lowerBound)
        }
    }
    
    
    // from 0...1
    func denormalize() -> (Float) -> (Float) {
        return { value in
            return self.lowerBound + (self.upperBound - self.lowerBound) * value
        }
    }
}
