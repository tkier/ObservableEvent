//
//  PropertyTests.swift
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

import XCTest
@testable import ObservableEvent

class PropertyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProperty() {
        
        let property: Property<Int>
        
        property = Property(1)
        XCTAssert(property.value == 1)

        property.value = 2
        XCTAssert(property.value == 2)
    }
    
    func testPropertySubscription() {
        
        let property = Property("hello")
        XCTAssert(property.value == "hello")
        
        var result = ""
        let disposable = property.observe { (value) in
            result = value
        }
        XCTAssert(result == "hello")
        
        property.value = "testing"
        XCTAssert(result == "testing")
        
        disposable.dispose()
        
        property.value = "more testing"
        XCTAssert(result == "testing")
        
    }
    
}
