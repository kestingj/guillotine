//
//  BackendIntegTests.swift
//  GuillotineAppTests
//
//  Created by Joseph Kesting on 7/28/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import XCTest
@testable import GuillotineApp

class BackendIntegTests: XCTestCase {

    
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
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNewGame() {
        
        let backend = Backend()
        let players = ["play1", "play2", "play3", "play4"]
        print(backend.startGame(players: players, startingPlayer: players[0]))
        assert(false)
    }
    
    func testGet() {
        let backend = Backend()
        backend.testGet()
    }

}
