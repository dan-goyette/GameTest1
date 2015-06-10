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
        SpriteUtils.DisableNodePhysics(self);
    }
    
    public convenience init(pieceValue: Int) {
        var size = CGSizeMake(CGFloat(SpriteUtils.GetGamePieceWidth(pieceValue)), CGFloat(AppConstants.UILayout.GamePieceHeight))
                
        self.init(texture:nil, color: UIColor.purpleColor(), size: size)
        
        self.PieceValue = pieceValue
        self.anchorPoint = CGPointMake(0.5,0);
        
        var label = SKLabelNode(text: String(pieceValue))
        label.fontSize = 18
        label.fontName = "Copperplate"
        label.fontColor = UIColor.whiteColor()
        self.addChild(label);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
