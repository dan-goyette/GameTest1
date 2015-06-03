//
//  SpriteUtils.swift
//  GameTest1
//
//  Created by Dan on 6/2/15.
//  Copyright (c) 2015 Dan. All rights reserved.
//

import Foundation
import SpriteKit

public class SpriteUtils {
    
    public static func DisableNodePhysics(node: SKNode) {
        node.physicsBody?.dynamic = false
        node.physicsBody?.collisionBitMask = 0x0;
        node.physicsBody?.contactTestBitMask = 0x0;
    }
    
    /** 
        Returns a list of tuples giving the position of each game pieces (relative to 0,0)
        within an abstract square the size of
    */
    public static func GetGamePiecePositions(gamePieces: [GamePiece]) -> [(gamePiece: GamePiece, position: CGPoint)] {
        var retval :[(gamePiece: GamePiece, position: CGPoint)] = []
        
        // Assume the frist piece has the greatest PieceValue.
        
        var offset = 0;
        for piece in gamePieces {
            var pieceWidth = GetGamePieceWidth( piece.PieceValue )
            
            var xPosition = AppConstants.UILayout.BoardSquareEdgeLength / 2;
            var yPosition = offset++ * AppConstants.UILayout.GamePieceHeight + 2;
            
            retval.append((gamePiece: piece, position: CGPointMake(CGFloat(xPosition), CGFloat(yPosition))));
        }
        
        return retval;
    }
    
    public static func GetGamePieceWidth(gamePieceValue: Int) -> Int {
        
        return ((AppConstants.UILayout.BoardSquareEdgeLength / 4) + (gamePieceValue * 15)) - 2
    }
}