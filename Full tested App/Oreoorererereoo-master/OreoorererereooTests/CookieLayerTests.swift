//
//  CookieLayerTests.swift
//  OreoorererereooTests
//
//  Created by Kamil Krzyszczak on 10/01/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import XCTest
@testable import Oreoorererereoo

final class CookieLayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testToppingLayer() {
        let layer = CookieLayer(place: 0, type: .Toping)
        XCTAssert(layer.type == .Toping)
    }
    
    func testFillingLayer() {
        let layer = CookieLayer(place: 0, type: .Filling)
        XCTAssert(layer.type == .Filling)
    }
    
    func testVisualizeShortFillingLayer() {
        let layer = CookieLayer(place: 0, type: .Filling)
        XCTAssert(layer.visualizeValue(width: 2) == "  ")
    }
    
    func testVisualizeFillingLayer() {
        let layer = CookieLayer(place: 0, type: .Filling)
        XCTAssert(layer.visualizeValue(width: 8) == " ░░░░░░ ")
    }
    
    func testVisualizeToppingLayer() {
        let layer = CookieLayer(place: 0, type: .Toping)
        XCTAssert(layer.visualizeValue(width: 8) == "████████")
    }
}
