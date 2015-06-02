//
//  GridSquare.swift
//  GameTest1
//
//  Created by Dan on 6/1/15.
//  Copyright (c) 2015 Dan. All rights reserved.
//

import Foundation
import SpriteKit


public class GridSquare : SKSpriteNode
{
    public var RowIndex : Int
    public var ColumnIndex : Int
    
    init(rowIndex: Int, columnIndex: Int) {
        self.RowIndex = rowIndex
        self.ColumnIndex = columnIndex
        
        var size = CGSizeMake(CGFloat(AppConstants.UILayout.BoardSquareEdgeLength), CGFloat(AppConstants.UILayout.BoardSquareEdgeLength))
        
        // Call the default initializer
        super.init(texture: nil, color: UIColor.clearColor(), size: size)
        
        let colorKey = RowIndex % 2 + ColumnIndex % 2
        
        // Alternate every color, but switch the alternation for each row. (That is, a checkerboard.)
        self.color = colorKey % 2 == 0 ? UIColor.blueColor() : UIColor.brownColor()
        self.size = size
        self.anchorPoint = CGPointMake(0,0);
        self.position = CGPoint(x: (AppConstants.UILayout.BoardSquareEdgeLength) * columnIndex, y: (AppConstants.UILayout.BoardSquareEdgeLength) * rowIndex);
        
        SpriteUtils.DisableNodePhysics(self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}
