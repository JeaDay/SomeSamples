//
//  OreoorererereooUITests.swift
//  OreoorererereooUITests
//
//  Created by Kamil Krzyszczak on 09/01/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import XCTest

class OreoorererereooUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testEnterWhitespace() {
        let textField = XCUIApplication().children(matching: .window).element(boundBy: 0).otherElements.children(matching: .textField).element
        textField.tap()
        textField.typeText(" ")
        let textView =  XCUIApplication().children(matching: .window).element(boundBy: 0).otherElements.children(matching: .textView).element
        textView.tap()
    }
    
    func testFullRun() {
        let textField = XCUIApplication().children(matching: .window).element(boundBy: 0).otherElements.children(matching: .textField).element
        textField.tap()
        textField.typeText("Orerereorereo")
        let textView =  XCUIApplication().children(matching: .window).element(boundBy: 0).otherElements.children(matching: .textView).element
        textView.tap()
    }

}
