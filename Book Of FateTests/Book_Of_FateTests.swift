//
//  Book_Of_FateTests.swift
//  Book Of FateTests
//
//  Created by Mike Schwab on 5/5/16.
//  Copyright © 2016 MICharisma. All rights reserved.
//

import XCTest
@testable import Book_Of_Fate

class Book_Of_FateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testBirthCardForMonth() {
        let input = MICCard.birthCardForMonth(5, day: 12)
        let output = MICCard(suit: "Diamonds", face: "Seven")
        XCTAssertEqual(input.suit, output.suit)
        XCTAssertEqual(input.face, output.face)
    }
    
    func testJokerBirthCard() {
        let input = MICCard.birthCardForMonth(12, day: 31)
        let output = MICCard(suit:"No Suit", face: "Joker")
        XCTAssertEqual(input.suit, output.suit)
        XCTAssertEqual(input.face, output.face)
    }
    
    func testCardForHour() {
        let rlc_example_date = NSDateComponents()
        rlc_example_date.year = 1953
        rlc_example_date.month = 7
        rlc_example_date.day = 3
        rlc_example_date.hour = 11
        let date = NSCalendar.currentCalendar().dateFromComponents(rlc_example_date)
        let output = date.card_for_hour()
        XCTAssertEqual(output, MICCard(suit: "Clubs", face: "Four"))
    }
}
