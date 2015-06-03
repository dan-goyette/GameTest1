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
    public var PieceValue : Int!
    
    override init(texture: SKTexture!, color: SKColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    public convenience init(pieceValue: Int) {
        var size = CGSizeMake(CGFloat(AppConstants.UILayout.BoardSquareEdgeLength), CGFloat(AppConstants.UILayout.BoardSquareEdgeLength))
                
        self.init(texture:nil, color: UIColor.greenColor(), size: size)
        
        self.PieceValue = pieceValue
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
