//
//  DisposeBag.swift
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

/// Implements a bag that contains Disopable objects. It will dispose all its contents when it is deinitialized, or when its dispose() method is called.
open class DisposeBag {
    
    private var disposables: [Disposable] = []
    
    public init() {}

    deinit {
        dispose()
    }
    
    /**
     
     Adds a Disposable to the bag.
     
     - Parameter disposable: The Disposable to add.
     */
    public func addDisposable(_ disposable: Disposable) {
        disposables.append(disposable)
    }
    
    /**
     
     Calls dispose on Disposables in the bag, and then empties itself.
     */
    public func dispose() {
        for disposable in disposables {
            disposable.dispose()
        }
        disposables.removeAll()
    }

}
