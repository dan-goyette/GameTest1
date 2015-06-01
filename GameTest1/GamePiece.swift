//
//  GamePiece.swift
//  GameTest1
//
//  Created by Dan on 5/31/15.
//  Copyright (c) 2015 Dan. All rights reserved.
//

import Foundation
import SpriteKit


public class GamePiece : SKShapeNode
{
    init(pieceValue: Int) {
        super.init()

        
        var width = 50 + (pieceValue - 1) * 10
        var height = 15
        
        var rectSize = CGSizeMake(CGFloat(width), CGFloat(height))
        
        var rect = CGRect(origin: CGPointZero, size: rectSize)
        self.path = CGPathCreateWithRect(rect, nil)
        self.fillColor = UIColor.purpleColor()
            
        
        // Put the number inside the box
        
        var label = SKLabelNode(text: String(pieceValue))
        label.position = CGPoint(x:CGRectGetMidX(rect), y:1)
        label.fontSize = 18
        label.fontColor = UIColor.whiteColor()
        self.addChild(label)

    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
