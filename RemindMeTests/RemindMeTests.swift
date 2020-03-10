//
//  RemindMeTests.swift
//  RemindMeTests
//
//  Created by Sahir Shahryar on 1/16/20.
//  Copyright © 2020 Sahir Shahryar. All rights reserved.
//

import XCTest
@testable import RemindMe

class RemindMeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // Knapsack test
        let inputData: [(item: String, weight: Int, value: Int)] = [
            (item: "Yeah", weight: 4, value: 5),
            (item: "Hello", weight: 5, value: 3),
            (item: "Soon", weight: 4, value: 10),
            (item: "Nearby", weight: 6, value: 8),
            (item: "Howdy", weight: 5, value: 2),
            (item: "Bye", weight: 3, value: 1)
        ]

        let output = knapsack(objects: inputData, maxWeight: 14)
                         .sorted(by: { $0.value > $1.value })

        print(output)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
