//
//  GamePiece.swift
//  GameTest1
//
//  Created by Dan on 5/31/15.
//  Copyright (c) 2015 Dan. All rights reserved.
//

import Foundation
import SpriteKit


public class GamePiece : SKSpriteNode
{
    public var PieceValue : Int
    
    init(pieceValue: Int) {
        self.PieceValue = pieceValue
        
        var size = CGSizeMake(CGFloat(AppConstants.UILayout.BoardSquareEdgeLength), CGFloat(AppConstants.UILayout.BoardSquareEdgeLength))
        
        // Call the default initializer
        super.init(texture: nil, color: UIColor.clearColor(), size: size)
        
        self.size = size
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
