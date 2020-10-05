//
//  CookieValidatorTests.swift
//  OreoorererereooTests
//
//  Created by Kamil Krzyszczak on 10/01/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import XCTest
@testable import Oreoorererereoo

final class CookieValidatorTests: XCTestCase {
    
    func testIsValidWhenEmpty() {
        XCTAssertFalse(CookieValidator().isValid(cookie: ""))
    }
    
    func testIsValidCookieShort() {
        XCTAssert(CookieValidator().isValid(cookie: "Oreo"))
    }
    
    func testIsValidCookieLong() {
        XCTAssert(CookieValidator().isValid(cookie: "Orerereo"))
    }
    
    func testIsValidCookieLongIsNotValidWhenLetter() {
        XCTAssertFalse(CookieValidator().isValid(cookie: "Oreprereo"))
    }
    
    func testIsValidCookieLongIsNotValidWhenNumber() {
        XCTAssertFalse(CookieValidator().isValid(cookie: "Oreprere1o"))
    }
    
    func testIsValidCookieLongIsNotValidWhenSpecial() {
        XCTAssertFalse(CookieValidator().isValid(cookie: "Orep+rere1o"))
    }
    
    func testIsValidLayers() {
        XCTAssert(CookieValidator().isValid(cookie: "Orerereo"))
    }
    
    func testIsValidLayersWhenMissingR() {
        XCTAssertFalse(CookieValidator().isValid(cookie: "Orereereo"))
    }
    
    func testIsValidLayersWhenMissingE() {
        XCTAssertFalse(CookieValidator().isValid(cookie: "Orerreo"))
    }
}
