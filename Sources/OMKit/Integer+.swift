//
//  File.swift
//  
//
//  Created by John Knowles on 7/28/24.
//

import Foundation

extension Int64 {
    var unsigned: UInt64 {
        let valuePointer = UnsafeMutablePointer<Int64>.allocate(capacity: 1)
        defer {
            valuePointer.deallocate()
        }

        valuePointer.pointee = self

        return valuePointer.withMemoryRebound(to: UInt64.self, capacity: 1) { $0.pointee }
    }
}

extension UInt64 {
    var signed: Int64 {
        let valuePointer = UnsafeMutablePointer<UInt64>.allocate(capacity: 1)
        defer {
            valuePointer.deallocate()
        }

        valuePointer.pointee = self

        return valuePointer.withMemoryRebound(to: Int64.self, capacity: 1) { $0.pointee }
    }
}


extension Int64 {
    var string: String {
       "\(self)"
    }
}

extension String {
    var int64: Int64? {
        Int64(self)
    }
    
    var uInt64: UInt64? {
        if let int64 = self.int64 {
            return int64.unsigned
        }
        
        return nil
    }
}

extension Int {
    func tableAlphabeticalLabel() -> String {
        var column = self + 1
        var label = String()
        let unicode = String("A").unicodeScalars
        let x = unicode[unicode.startIndex].value

        
        while (column > 0) {
            let modulo = (column - 1) % 26
            let character = x + UInt32(modulo)
            let scalar = UnicodeScalar(character)
            
            label = String(Character(scalar ?? unicode.first ?? .init(64))) + label
            column = (column - modulo) / 26
        }
        return label

    }
}


extension UInt16 {
    init(byte1: UInt8, byte2: UInt8) {
        let bytes: [UInt8] = [byte1, byte2]
        let u16 = bytes.withUnsafeBytes { $0.load(as: UInt16.self) }
        self = u16
    }
    
    
}

func combineIntoUInt8(_ a: UInt8, _ b: UInt8) -> UInt16 {
    let bytes = [a,b]
    return UInt16(bytes[0]) << 8 | UInt16(bytes[1])
}

func breakIntoUInt8(_ a: UInt16) -> (UInt8, UInt8) {
    (UInt8(a >> 8),
    UInt8(a & 0x00ff))
}
 

