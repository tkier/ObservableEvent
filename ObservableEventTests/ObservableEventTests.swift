//
//  ObservableEventTests.swift
//  ObservableEventTests
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

import XCTest
@testable import ObservableEvent

class ObservableEventTests: XCTestCase {
    
    var eventValue :String?
    
    func testNotify() {
        
        let event = ObservableEvent<Int>()
        
        var observerdValue = 0
        
        let disposable = event.observe { value in
            observerdValue = value
        }
        
        XCTAssert(observerdValue == 0)
        
        event.notifyObservers(1)
        XCTAssert(observerdValue == 1)
        
        event.notifyObservers(2)
        XCTAssert(observerdValue == 2)
        
        disposable.dispose()
        
        event.notifyObservers(3)
        XCTAssert(observerdValue == 2)
    }
    
    func testMultipleObservers() {
        
        let event = ObservableEvent<Int>()
        
        var observerdValue1 = 0
        var observerdValue2 = 0
        
        let disposable1 = event.observe { value in
            observerdValue1 = value
        }
        let disposable2 = event.observe { value in
            observerdValue2 = value
        }
        
        XCTAssert(observerdValue1 == 0)
        XCTAssert(observerdValue2 == 0)
        
        event.notifyObservers(1)
        XCTAssert(observerdValue1 == 1)
        XCTAssert(observerdValue2 == 1)
        
        event.notifyObservers(2)
        XCTAssert(observerdValue1 == 2)
        XCTAssert(observerdValue2 == 2)
        
        disposable1.dispose()
        
        event.notifyObservers(3)
        XCTAssert(observerdValue1 == 2)
        XCTAssert(observerdValue2 == 3)
        
        disposable2.dispose()
        
        event.notifyObservers(4)
        XCTAssert(observerdValue1 == 2)
        XCTAssert(observerdValue2 == 3)
    }
    
    func testVoidEvent() {
        
        let event = ObservableEvent<Void>()
        
        var eventFired = false
        
        let disposable = event.observe {
            eventFired = true
        }
        
        XCTAssertFalse(eventFired)
        
        event.notifyObservers()
        
        XCTAssertTrue(eventFired)
        
        disposable.dispose()
    }
    
    func testTupleEvent() {
        
        let event = ObservableEvent<(Int, Int)>()
        
        var result1 = 0
        var result2 = 0
        
        let disposable = event.observe { a, b in
            result1 = a
            result2 = b
        }
        
        XCTAssert(result1 == 0)
        XCTAssert(result2 == 0)
        
        event.notifyObservers((1, 2))
        
        XCTAssert(result1 == 1)
        XCTAssert(result2 == 2)
        
        disposable.dispose()
    }
    
    func testObserverMethod() {
        
        let event = ObservableEvent<String>()
        
        eventValue = nil
        
        let disposable = event.observe(eventChanged)
        
        XCTAssertNil(eventValue)
        
        event.notifyObservers("It Works!!")
        
        XCTAssert(eventValue == "It Works!!")
        
        disposable.dispose()
    }
    
    func eventChanged(value:String) {
        eventValue = value
    }
}
