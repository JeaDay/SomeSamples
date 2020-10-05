//
//  StringExtensionsTests.swift
//  OreoorererereooTests
//
//  Created by Kamil Krzyszczak on 10/01/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import XCTest
@testable import Oreoorererereoo

final class StringExtensionsTests: XCTestCase {
    
    let testingData = "Hot-Dog"

    override func setUp() {
        super.setUp()
    }
    
    func testMiddleCharacter() {
        XCTAssert(testingData[3] == "-")
    }
    
    func testFirstCharacter() {
        XCTAssert(testingData[0] == "H")
    }
    
    func testLastCharacter() {
        XCTAssert(testingData[6] == "g")
    }
    
    func testOutOfBoundsCharacter() {
        XCTAssertNil(testingData[20])
    }
    
    func testEmptyStringSubscript() {
        XCTAssertNil(""[3])
    }
}
