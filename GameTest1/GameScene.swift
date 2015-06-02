//
//  GameScene.swift
//  GameTest1
//
//  Created by Dan on 5/30/15.
//  Copyright (c) 2015 Dan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var gameCircles = [SKShapeNode]()
    var mainSquare = SKSpriteNode()
    var rowCount = 5
    var columnCount = 6
    var gridSquareEdgeLength = 100
    
    
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
        
        SpriteUtils.DisableNodePhysics(mainSquare)

        
        for rowIndex in 0 ..< rowCount {
            for columnIndex in 0 ..< columnCount {
                let gridSquare = GridSquare(rowIndex: rowIndex, columnIndex: columnIndex)
                mainSquare.addChild(gridSquare)
            }
        }
        
        self.addChild(mainSquare)


        
        var gamePiece1 = GamePiece(pieceValue: 5)
        self.addChild(gamePiece1)
        putShapeAtCoordinates(gamePiece1, rowIndex: 4, columnIndex: 4, animate: false)

        // We need to add things that render as sprites, but have more logic. 
        // This means subclasses of sprites.
      
    }
 
    
    func addCircleAtCoordinates(rowIndex: Int, columnIndex: Int) {
   
        var radius = CGFloat(gridSquareEdgeLength / 4 )
        var circle = SKShapeNode(circleOfRadius: radius) // Size of Circle
        
        circle.strokeColor = SKColor.blackColor()
        circle.glowWidth = 1.0
        circle.fillColor = SKColor.orangeColor()
        
      
        SpriteUtils.DisableNodePhysics(circle)


        gameCircles.append(circle)
        
//        
//        let sparkEmmiter = SKEmitterNode(fileNamed: "MyParticle.sks")
//        
//        sparkEmmiter.name = "sparkEmmitter"
//        sparkEmmiter.zPosition = 1
//        sparkEmmiter.targetNode = self
//        sparkEmmiter.particleLifetime = 1
//        
//        circle.addChild(sparkEmmiter)
        
        
        
        self.addChild(circle)
        
        putShapeAtCoordinates(circle, rowIndex: rowIndex,columnIndex:columnIndex, animate: false)

    }
    func putShapeAtCoordinates(circle: SKNode, rowIndex: Int, columnIndex: Int, animate: Bool) {
        
        if (rowIndex < 0 || rowIndex >= self.rowCount
            || columnIndex < 0 || columnIndex >= self.columnCount) {
                
                if (animate) {
                    var moveToPoint = SKAction.moveTo(self.selectedCircleInitialPosition!, duration:0.3)
                    circle.runAction(moveToPoint)
                } else {
                    circle.position = self.selectedCircleInitialPosition!
                }
        } else {
            
            // position of the circle is the base position of the main square, plus the
            // row/column offsets, plus 1/4 the row/column offset to out the circle in the middle
            // of the square.
            var xPosition = mainSquare.position.x + CGFloat(columnIndex * gridSquareEdgeLength)
            var yPosition = mainSquare.position.y + CGFloat(rowIndex * gridSquareEdgeLength)
            
            if (animate) {
                var moveToPoint = SKAction.moveTo(CGPointMake(xPosition,yPosition), duration:0.1)
                circle.runAction(moveToPoint)
            } else {
                circle.position = CGPointMake(xPosition,yPosition)
            }
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
                putShapeAtCoordinates(lastSelectedCircle!, rowIndex: yPosition, columnIndex: xPosition, animate: true)
                lastSelectedCircle = nil;
                selectedCircleInitialPosition = nil;
            }
        }
        
        
        //self.revertLastSelectedNode();
    }
  
    
    
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
