//
//  EventDisposable.swift
//  ObservableEvent
//
//  Created by Tom Kier on 4/29/17.
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

internal typealias RemoveObserver = () -> Void

internal class EventDisposable: Disposable {
    
    private var removeObserver: RemoveObserver?
    
    internal init(_ removeObserver: @escaping RemoveObserver) {
        self.removeObserver = removeObserver
    }
    
    public func dispose() {
        removeObserver?()
        removeObserver = nil
    }
    
    public func disposeWith(_ disposeBag: DisposeBag) {
        disposeBag.addDisposable(self)
    }
}
