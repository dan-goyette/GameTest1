//
//  GridSquareTests.swift
//  GameTest1
//
//  Created by Dan on 6/2/15.
//  Copyright (c) 2015 Dan. All rights reserved.
//

import UIKit
import XCTest
import GameTest1

class GridSquareTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCanAddGamePiece() {
        var gamePiece_v1_1 = GamePiece(pieceValue: 1)
        var gamePiece_v1_2 = GamePiece(pieceValue: 1)
        var gamePiece_v2_1 = GamePiece(pieceValue: 2)
        var gamePiece_v2_2 = GamePiece(pieceValue: 2)
        var gamePiece_v3_1 = GamePiece(pieceValue: 3)
        var gamePiece_v3_2 = GamePiece(pieceValue: 3)
        var gamePiece_v4_1 = GamePiece(pieceValue: 4)
        var gamePiece_v4_2 = GamePiece(pieceValue: 4)
        var gamePiece_v5_1 = GamePiece(pieceValue: 5)
        var gamePiece_v5_2 = GamePiece(pieceValue: 5)
        
        var gridSquare = GridSquare(rowIndex: 0, columnIndex: 0)
        
        
        // Add a "5". Then try to add another "5".
        XCTAssertTrue(gridSquare.tryAddGamePiece(gamePiece_v5_1))
        XCTAssertFalse(gridSquare.tryAddGamePiece(gamePiece_v5_2))
        
        // Remove the "5"
        XCTAssertTrue(gridSquare.tryRemoveGamePiece(gamePiece_v5_1))
        
        // Add "5" through "1" in order.
        XCTAssertTrue(gridSquare.tryAddGamePiece(gamePiece_v5_1))
        XCTAssertTrue(gridSquare.tryAddGamePiece(gamePiece_v4_1))
        XCTAssertTrue(gridSquare.tryAddGamePiece(gamePiece_v3_1))
        XCTAssertTrue(gridSquare.tryAddGamePiece(gamePiece_v2_1))
        XCTAssertTrue(gridSquare.tryAddGamePiece(gamePiece_v1_1))
        
        
        // We can't remove 2-5 because 1 is on top.
        XCTAssertFalse(gridSquare.tryRemoveGamePiece(gamePiece_v2_1))
        XCTAssertFalse(gridSquare.tryRemoveGamePiece(gamePiece_v3_1))
        XCTAssertFalse(gridSquare.tryRemoveGamePiece(gamePiece_v4_1))
        XCTAssertFalse(gridSquare.tryRemoveGamePiece(gamePiece_v5_1))
        
        // Remove the "1" first and we can remove the rest.
        XCTAssertTrue(gridSquare.tryRemoveGamePiece(gamePiece_v1_1))
        XCTAssertTrue(gridSquare.tryRemoveGamePiece(gamePiece_v2_1))
        XCTAssertTrue(gridSquare.tryRemoveGamePiece(gamePiece_v3_1))
        XCTAssertTrue(gridSquare.tryRemoveGamePiece(gamePiece_v4_1))
        XCTAssertTrue(gridSquare.tryRemoveGamePiece(gamePiece_v5_1))
        
        // The grid should be empty.
        XCTAssertEqual(gridSquare.getGamePieces().count, 0)
        
        // Add "4".
        XCTAssertTrue(gridSquare.tryAddGamePiece(gamePiece_v4_1))
        
        // Ensure we can't add "5" now, but that we can add "3".
        XCTAssertFalse(gridSquare.tryAddGamePiece(gamePiece_v5_1))
        XCTAssertTrue(gridSquare.tryAddGamePiece(gamePiece_v3_1))

        
    }
    
    
    
}