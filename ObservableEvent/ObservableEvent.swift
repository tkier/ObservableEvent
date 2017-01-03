//
//  ObservableEvent.swift
//  ObservableEvent
//
//  Created by Tom Kier on 5/14/16.
//
//  Copyright 2016 Endless Wave Software LLC
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

public typealias RemoveObserver = () -> Void

/// Implements a simple observer pattern
open class ObservableEvent<T> {
    
    fileprivate var observers: [(Int, (T) -> Void)] = []
    fileprivate var nextId = ObservableEvent<T>.idGenerator()
    
    public init() {}
    
    /**
     
     Adds an observer to this event.
     
     - Parameter observer: A closure that will be called when notifyObservers is called.
     
     - Returns: A closure that can be called later to remove the observer.
     
     */
    open func addObserver(_ observer: @escaping (T) -> Void) -> RemoveObserver {
        let id = nextId()
        observers.append((id, observer))
        
        return { [weak self] in
            self?.removeObserverForId(id)
        }
    }
    
    /**
     
      Notify all observers of this event.
     
     - Parameter data: A data value to pass to the observers.
     
     */
    open func notifyObservers(_ data: T) {
        for observer in observers {
            observer.1(data)
        }
    }
    
    fileprivate func removeObserverForId(_ id:Int) {
        observers = observers.filter { $0.0 != id }
    }
    
    fileprivate static func idGenerator() -> () -> Int {
        var lastId = 0
        return {
            lastId += 1
            return lastId
        }
    }
}
