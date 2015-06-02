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
    
    init() {
        self.gamePieces = [GamePiece]()
        
        var size = CGSizeMake(CGFloat(AppConstants.UILayout.BoardSquareEdgeLength), CGFloat(AppConstants.UILayout.BoardSquareEdgeLength))
        
        // Call the default initializer
        super.init(texture: nil, color: UIColor.clearColor(), size: size)
        
        self.size = size
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addGamePiece(gamePiece: GamePiece)
    {
        gamePieces.append(gamePiece)
        
        self.addChild(gamePiece)
        gamePiece.position = CGPointMake(self.position.x, self.position.y + CGFloat(15 * gamePieces.count))
    }
    
    public func getGamePieces() -> [GamePiece] {
        return gamePieces
    }
    
    private var gamePieces : [GamePiece]}

