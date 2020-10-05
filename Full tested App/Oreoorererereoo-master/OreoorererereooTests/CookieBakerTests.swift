//
//  CookieBakerTests.swift
//  OreoorererereooTests
//
//  Created by Kamil Krzyszczak on 09/01/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import XCTest
@testable import Oreoorererereoo

final class CookieBakerTests: XCTestCase {

    override func setUp() {}
    
    func testBakeFillingLayer() {
        let layer = CookieBaker().bakeLayer(cookie: "Oreo", index: 1)
        XCTAssert(layer?.type == LayerType.Filling)
    }
    
    func testBakeToppingLayer() {
        let layer = CookieBaker().bakeLayer(cookie: "Oreo", index: 0)
        XCTAssert(layer?.type == LayerType.Toping)
    }
    
    func testBakeEmptyToppingLayer() {
        XCTAssertNil(CookieBaker().bakeLayer(cookie: "", index: 0))
    }
    
    func tesBaketMissingLayer() {
        XCTAssertNil(CookieBaker().bakeLayer(cookie: "Orereo", index: 10))
    }
    
    func testBakeNumberOfLayersWhenShortCookie() {
        XCTAssert(CookieBaker().bake(cookie: "Oreo")!.count == 3)
    }
    
    func testBakeNumberOfLayersOnLongCookie() {
        XCTAssert(CookieBaker().bake(cookie: "Orereoreo")!.count == 6)
    }
    
    func testBakeNonValidCookie() {
        XCTAssertNil(CookieBaker().bake(cookie: "Ore0reo"))
    }
    
    func testBakeEmptyCookie() {
        XCTAssertNil(CookieBaker().bake(cookie: ""))
    }
}
