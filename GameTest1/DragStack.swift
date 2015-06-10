//
//  DragStack.swift
//  GameTest1
//
//  Created by Dan on 6/1/15.
//  Copyright (c) 2015 Dan. All rights reserved.
//

import Foundation
import SpriteKit

public class DragStack : SKSpriteNode
{
    private var GamePieces : [GamePiece]!

    override init(texture: SKTexture!, color: SKColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        SpriteUtils.DisableNodePhysics(self);
    }
    
    public convenience init(gamePieces : [GamePiece]) {
        var size = CGSizeMake(CGFloat(AppConstants.UILayout.BoardSquareEdgeLength), CGFloat(AppConstants.UILayout.BoardSquareEdgeLength))
        
        self.init(texture:nil, color: UIColor.clearColor(), size: size)
        
        self.GamePieces = gamePieces
        for gamePiece in self.GamePieces {
            self.addChild(gamePiece)
        }
        self.anchorPoint = CGPointMake(0.0, 0.0)
        self.refreshGamePiecePositions();
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func getGamePieces() -> [GamePiece] {
        return GamePieces;
    }
    
    private func refreshGamePiecePositions() {
        for tuple in SpriteUtils.GetGamePiecePositions(self.GamePieces) {
            tuple.gamePiece.position = tuple.position
        }
    }
}

