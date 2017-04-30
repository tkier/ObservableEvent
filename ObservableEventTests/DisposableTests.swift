//
//  DisposableTests.swift
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

class DisposableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDisposable() {
        
        let property = Property(1)
        
        var result = 0
        let disposable = property.observe { value in
            result = value
        }
        XCTAssert(result == 1)

        disposable.dispose()
        XCTAssert(result == 1)

        property.value = 2
        XCTAssert(result == 1)
    }
    
    func testDisposableBag() {
        
        let bag = DisposeBag()
        let property = Property(1)
        
        var result = 0
        property.observe { value in
            result = value
        }.disposeWith(bag)
        XCTAssert(result == 1)
        
        property.value = 2
        XCTAssert(result == 2)
        
        bag.dispose()
        
        property.value = 3
        XCTAssert(result == 2)
    }
    
    func testDisposableBagDisposeOnDeinit() {
     
        var result = 0
        let property = Property(1)

        let disposable = property.observe { value in
            result = value
        }
        XCTAssert(result == 1)

        if true {
            let bag = DisposeBag()
           
            bag.addDisposable(disposable)
           
            property.value = 2
            XCTAssert(result == 2)
        }
        
        property.value = 3
        XCTAssert(result == 2)

    }
}
