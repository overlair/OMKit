//
//  File.swift
//  
//
//  Created by John Knowles on 7/28/24.
//

import Combine

@available(macOS 12, *)
@available(iOS 13.0, *)
public typealias Message<T> = PassthroughSubject<T, Never>

@available(macOS 12, *)
@available(iOS 13.0, *)
public typealias Trigger = PassthroughSubject<Void, Never>

@available(macOS 12, *)
@available(iOS 13.0, *)
public typealias Value<T> = CurrentValueSubject<T, Never>

@available(macOS 12, *)
@available(iOS 13.0, *)
public extension Trigger {
    func fire()
        { self.send(()) }
}

@available(macOS 12, *)
@available(iOS 13.0, *)
public extension Value {
    func set(_ newValue: Output)
        { self.send(newValue) }
}

@available(macOS 12, *)
@available(iOS 13.0, *)
public extension Value where Output == Bool {
    func toggle(){
        self.set(!self.value)
    }
}

