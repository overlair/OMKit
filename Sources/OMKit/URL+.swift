//
//  File.swift
//  
//
//  Created by John Knowles on 7/28/24.
//

import Foundation

extension URL {
    func toBookmarkData() -> Data? {
        guard self.startAccessingSecurityScopedResource() else {
            return nil
        }
        
        defer { self.stopAccessingSecurityScopedResource() }
        do {
            return try self.bookmarkData(options: .suitableForBookmarkFile)
        } catch {
            return  nil
        }
  
    }
}
