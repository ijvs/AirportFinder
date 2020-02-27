//
//  Bindable.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//
// Source: https://www.swiftbysundell.com/articles/bindable-values-in-swift/

import Foundation

class Bindable<Value> {
    private var observations = [(Value) -> Bool]()
    private var lastValue: Value?

    init(_ value: Value? = nil) {
        lastValue = value
    }
}

extension Bindable {
    func addObservation<O: AnyObject>(
        for object: O,
        handler: @escaping (O, Value) -> Void
    ) {
        // If we already have a value available, we'll give the
        // handler access to it directly.
        lastValue.map { handler(object, $0) }

        // Each observation closure returns a Bool that indicates
        // whether the observation should still be kept alive,
        // based on whether the observing object is still retained.
        observations.append { [weak object] value in
            guard let object = object else {
                return false
            }

            handler(object, value)
            return true
        }
    }
}

extension Bindable {
    func update(with value: Value) {
        lastValue = value
        observations = observations.filter { $0(value) }
    }
}
