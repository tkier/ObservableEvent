//
//  Property.swift
//  ObservableEvent
//
//  Created by Tom Kier on 4/27/17.
//
//  Copyright 2017 Endless Wave Software LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import Foundation

/// Implements an observable property that notifies observers whenever its value is changed.
open class Property<T> {
    
    /**
     
     The value of the property. When the value is set, all observers are called.
     */
    public var value: T {
        didSet {
            observableEvent.notifyObservers(value)
        }
    }
    private var observableEvent: ObservableEvent<T>
    
    /**
     
     Initializes a property and sets its initial value.
     
     - Parameter intialValue: The initial value of the property.
     */
    public init(_ intialValue: T) {
        value = intialValue
        observableEvent = ObservableEvent()
    }
    
    /**
     
     Adds an observer to this property.
     
     - Parameter observer: A closure that will be called when the observer is intially added and anytime the property value is changed.
     
     - Returns: A Disposable that will remove the observer when it is disposed.
     
     */
    public func observe(_ observer: @escaping (T) -> Void) -> Disposable {
        observer(value)
        return observableEvent.observe(observer)
    }
}
