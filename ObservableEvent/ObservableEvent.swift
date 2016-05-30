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

public class ObservableEvent<T> {
    
    private var observers: [(Int, T -> Void)] = []
    private var nextId = ObservableEvent<T>.idGenerator()
    
    public init() {}
    
    public func addObserver(observer: T -> Void) -> RemoveObserver {
        let id = nextId()
        observers.append((id, observer))
        
        return { [weak self] in
            self?.removeObserverForId(id)
        }
    }
    
    public func notifyObservers(data: T) {
        for observer in observers {
            observer.1(data)
        }
    }
    
    private func removeObserverForId(id:Int) {
        self.observers = self.observers.filter { $0.0 != id }
    }
    
    private static func idGenerator() -> () -> Int {
        var lastId = 0
        return {
            lastId += 1
            return lastId
        }
    }
}
