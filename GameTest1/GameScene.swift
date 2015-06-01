//
//  GameScene.swift
//  GameTest1
//
//  Created by Dan on 5/30/15.
//  Copyright (c) 2015 Dan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var gridSquareName = "gridSquare"
    var pieceName = "pieceSquare"
    var gameCircles = [SKShapeNode]()
    var mainSquare = SKSpriteNode()
    var rowCount = 5
    var columnCount = 6
    var gridSquareEdgeLength = 100
    
    let boxCategory: UInt32 = 0x1 << 0
    let circleCategory: UInt32 = 0x1 << 1

    
    override func didMoveToView(view: SKView) {
        createTileGrid()
    }
    
    func createTileGrid() {
        
        var mainSquareWidth : Int = columnCount * gridSquareEdgeLength
        var mainSquareHeight : Int = rowCount * gridSquareEdgeLength
        
        mainSquare.size = CGSize(width: mainSquareWidth , height: mainSquareHeight)
        mainSquare.anchorPoint = CGPointMake(0,0)
        mainSquare.position = CGPoint(x:CGRectGetMidX(self.frame) - CGFloat(mainSquareWidth / 2),
            y:CGRectGetMidY(self.frame) - CGFloat(mainSquareHeight / 2))
        mainSquare.color = UIColor.redColor()
        
//        mainSquare.physicsBody?.dynamic = false
//        mainSquare.physicsBody?.collisionBitMask = 0x0;
//        mainSquare.physicsBody?.contactTestBitMask = 0x0;


        
        for rowIndex in 0 ..< rowCount {
            for columnIndex in 0 ..< columnCount {
                let gridSquare = SKSpriteNode()
                let colorKey = rowIndex % 2 + columnIndex % 2
                
                // Alternate every color, but switch the alternation for each row. (That is, a checkerboard.)
                gridSquare.color = colorKey % 2 == 0 ? UIColor.blueColor() : UIColor.brownColor()
                
                gridSquare.size = CGSize(width: gridSquareEdgeLength, height: gridSquareEdgeLength)
                gridSquare.anchorPoint = CGPointMake(0,0);
                gridSquare.position = CGPoint(x: gridSquareEdgeLength * columnIndex, y: gridSquareEdgeLength * rowIndex);

                gridSquare.physicsBody?.dynamic = false
                gridSquare.physicsBody?.collisionBitMask = 0x0;
                gridSquare.physicsBody?.contactTestBitMask = 0x0;
                
                gridSquare.name = self.gridSquareName
                
                mainSquare.addChild(gridSquare)
                
                
            }
        }
        
        self.addChild(mainSquare)

//        for rowIndex in 0 ..< rowCount {
//            for columnIndex in 0 ..< columnCount {
//
//        addCircleAtCoordinates( rowIndex, columnIndex: columnIndex)
//            }
//        }

        addCircleAtCoordinates( 3, columnIndex: 2)
        
        addCircleAtCoordinates( 1, columnIndex: 4)
        
        

        
      
    }
    
    func addCircleAtCoordinates(rowIndex: Int, columnIndex: Int) {
   
        var radius = CGFloat(gridSquareEdgeLength / 4 )
        var circle = SKShapeNode(circleOfRadius: radius) // Size of Circle
        
        circle.strokeColor = SKColor.blackColor()
        circle.glowWidth = 1.0
        circle.fillColor = SKColor.orangeColor()
        
//        circle.physicsBody?.dynamic = false
//        circle.physicsBody?.collisionBitMask = 0x0;
//        circle.physicsBody?.contactTestBitMask = 0x0;

        gameCircles.append(circle)
        self.addChild(circle)
        
        putCircleAtCoordinates(circle, rowIndex: rowIndex,columnIndex:columnIndex)

    }
    func putCircleAtCoordinates(circle: SKShapeNode, rowIndex: Int, columnIndex: Int) {
        
        if (rowIndex < 0 || rowIndex >= self.rowCount
            || columnIndex < 0 || columnIndex >= self.columnCount) {
                circle.position = self.selectedCircleInitialPosition!
        } else {
            
            // position of the circle is the base position of the main square, plus the
            // row/column offsets, plus 1/4 the row/column offset to out the circle in the middle
            // of the square.
            var xPosition = mainSquare.position.x + CGFloat(columnIndex * gridSquareEdgeLength) + CGFloat(gridSquareEdgeLength / 2)
            var yPosition = mainSquare.position.y + CGFloat(rowIndex * gridSquareEdgeLength) + CGFloat(gridSquareEdgeLength / 2)

            circle.position = CGPointMake(xPosition,yPosition)
        }
    }
    
    
    var lastSelectedNode : SKSpriteNode? = nil;
    var lastSelectedColor : UIColor? = nil;
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            //self.doNodeColorChange(location)
            
            if (lastSelectedCircle != nil) {
                lastSelectedCircle?.position = location
            }
        }
    }
    
    var lastSelectedCircle : SKShapeNode? = nil;
    var selectedCircleInitialPosition : CGPoint? = nil;
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            //self.doNodeColorChange(location)
            
            for node in self.nodesAtPoint(location) {
                if let shapeNode = node as? SKShapeNode {
                    if (contains (gameCircles, shapeNode)) {
                        lastSelectedCircle = shapeNode
                        selectedCircleInitialPosition = lastSelectedCircle?.position
                    }
                }
            }
            
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        // TODO Move selected circle to proper position.
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)

            if (lastSelectedCircle != nil) {
                var xPosition = Int(floor((location.x - mainSquare.position.x) / CGFloat(gridSquareEdgeLength)))
                var yPosition = Int(floor((location.y - mainSquare.position.y) / CGFloat(gridSquareEdgeLength)))
                putCircleAtCoordinates(lastSelectedCircle!, rowIndex: yPosition, columnIndex: xPosition)
                lastSelectedCircle = nil;
                selectedCircleInitialPosition = nil;
            }
        }
        
        
        //self.revertLastSelectedNode();
    }
    
//    func doNodeColorChange(location: CGPoint) {
//        // Find the node at the touch postion, if one exists.
//        
//        var currentNode = self.nodeAtPoint(location) as? SKSpriteNode
//        
//        if (currentNode != nil) {
//            
//            
//            if (currentNode!.name != gridSquareName) {
//                // If the current node isn't a gridSquareNode, then the only possible
//                // thing to do is reset the node's color, as long as lastSelectedNode
//                // isn't nil
//                
//                //revertLastSelectedNode()
//            } else {
//                // Either the lastSelectedNode is nil or it's set to something.
//                // If it's nil, we don't worry about it,
//                // If it's something, and different from the current node, we revert it.
//                
//                if (currentNode != lastSelectedNode) {
//                    revertLastSelectedNode()
//                    
//                    self.lastSelectedNode = currentNode
//                    self.lastSelectedColor = currentNode!.color
//                    currentNode!.color = UIColor.purpleColor()
//                    
//                }
//            }
//        }
//
//    }
    
    
    func revertLastSelectedNode() {
        if (self.lastSelectedNode != nil) {
            self.lastSelectedNode!.color = self.lastSelectedColor!
            self.lastSelectedNode = nil
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
