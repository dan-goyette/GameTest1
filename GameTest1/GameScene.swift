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
    var GridSquares = [GridSquare]()
    
    var inventoryBoundsSquare = SKSpriteNode()
    var InventorySquares = [GridSquare]()
    
    var rowCount = 5
    var columnCount = 6
    
    var score = 0
    var scoreLabel = SKLabelNode(text: "")
    
    
    override func didMoveToView(view: SKView) {
        createTileGrid()
        createInventoryGrid()
        addScoreLabel()
    }
    
    func addScoreLabel() {
        var staticScoreLabel = SKLabelNode(text: "Score:")
        staticScoreLabel.position = CGPointMake(50, CGRectGetMaxY(self.frame) - CGFloat(50))
        self.addChild(staticScoreLabel)
        
        scoreLabel.position = CGPointMake(125, CGRectGetMaxY(self.frame) - CGFloat(50))
        self.addChild(scoreLabel)
        
        addToScore(0)
        
        self.userInteractionEnabled = true
    }
    
    func createTileGrid() {
        
        var mainSquareWidth : Int = columnCount * AppConstants.UILayout.BoardSquareEdgeLength
        var mainSquareHeight : Int = rowCount * AppConstants.UILayout.BoardSquareEdgeLength
        
        mainSquare.size = CGSize(width: mainSquareWidth , height: mainSquareHeight)
        mainSquare.anchorPoint = CGPointMake(0,0)
        mainSquare.position = CGPoint(x:CGRectGetMidX(self.frame) - CGFloat(mainSquareWidth / 2),
            y:CGRectGetMidY(self.frame) - CGFloat(mainSquareHeight / 2))
        mainSquare.color = UIColor.redColor()
        
        SpriteUtils.DisableNodePhysics(mainSquare)

        
        for rowIndex in 0 ..< rowCount {
            for columnIndex in 0 ..< columnCount {
                let gridSquare = GridSquare(rowIndex: rowIndex, columnIndex: columnIndex, isInventorySquare: false)
                GridSquares.append(gridSquare);
                mainSquare.addChild(gridSquare)
            }
        }
        
        self.addChild(mainSquare)
        
        
        // Add a few game pieces to one of the grid squares.
        var gamePiece5_1 = GamePiece(pieceValue: 5)
        var gamePiece4_1 = GamePiece(pieceValue: 4)
        var gamePiece3_1 = GamePiece(pieceValue: 3)
        var gamePiece2_1 = GamePiece(pieceValue: 2)
        var gamePiece1_1 = GamePiece(pieceValue: 1)
        
        var gridSquare_2_2 = getGridSquareAtRowAndColumnIndex(2, columnIndex: 2)!
        //gridSquare_2_2.tryAddGamePiece(gamePiece5_1);
        gridSquare_2_2.tryAddGamePiece(gamePiece4_1);
        gridSquare_2_2.tryAddGamePiece(gamePiece3_1);
        gridSquare_2_2.tryAddGamePiece(gamePiece2_1);
        gridSquare_2_2.tryAddGamePiece(gamePiece1_1);
        
        
        
        var gamePiece5_2 = GamePiece(pieceValue: 5)
        var gamePiece2_2 = GamePiece(pieceValue: 2)
        var gamePiece1_2 = GamePiece(pieceValue: 1)
        
        var gridSquare_3_1 = getGridSquareAtRowAndColumnIndex(3, columnIndex: 1)!
        gridSquare_3_1.tryAddGamePiece(gamePiece5_2);
        gridSquare_3_1.tryAddGamePiece(gamePiece2_2);
        gridSquare_3_1.tryAddGamePiece(gamePiece1_2);

        var gridSquare_4_1 = getGridSquareAtRowAndColumnIndex(4, columnIndex: 1)!
        gridSquare_4_1.tryAddGamePiece(GamePiece(pieceValue: 4))
        gridSquare_4_1.tryAddGamePiece(GamePiece(pieceValue: 2))
        
        
        var gridSquare_2_5 = getGridSquareAtRowAndColumnIndex(2, columnIndex: 5)!
        gridSquare_2_5.tryAddGamePiece(GamePiece(pieceValue: 5))
        gridSquare_2_5.tryAddGamePiece(GamePiece(pieceValue: 4))
        gridSquare_2_5.tryAddGamePiece(GamePiece(pieceValue: 3))
        gridSquare_2_5.tryAddGamePiece(GamePiece(pieceValue: 1))
        
        
        
      
    }
    
    
    func createInventoryGrid() {
        
        var inventorySquareWidth : Int = columnCount * AppConstants.UILayout.BoardSquareEdgeLength
        var inventorySquareHeight : Int = 1 * AppConstants.UILayout.BoardSquareEdgeLength
        
        inventoryBoundsSquare.size = CGSize(width: inventorySquareWidth , height: inventorySquareHeight)
        inventoryBoundsSquare.anchorPoint = CGPointMake(0,0)
        inventoryBoundsSquare.position = CGPoint(x:CGRectGetMidX(self.frame) - CGFloat(inventorySquareWidth / 2),
            y:CGRectGetMaxY(self.frame) - CGFloat(inventorySquareHeight))
        inventoryBoundsSquare.color = UIColor.redColor()
        
        SpriteUtils.DisableNodePhysics(inventoryBoundsSquare)
        
        
            for columnIndex in 0 ..< columnCount {
                let inventorySquare = GridSquare(rowIndex: 0, columnIndex: columnIndex, isInventorySquare: true)
                InventorySquares.append(inventorySquare);
                inventoryBoundsSquare.addChild(inventorySquare		)
            }
        
        
        self.addChild(inventoryBoundsSquare)
    }
    

    
    
    func getGridSquareAtRowAndColumnIndex(rowIndex: Int, columnIndex: Int) -> GridSquare? {
        for gridSquare in self.GridSquares {
            if (gridSquare.RowIndex == rowIndex && gridSquare.ColumnIndex == columnIndex) {
                return gridSquare;
            }
        }
        
        return nil;
    }
 

    
    func addCircleAtCoordinates(rowIndex: Int, columnIndex: Int) {
   
        var radius = CGFloat(AppConstants.UILayout.BoardSquareEdgeLength / 4 )
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
            var xPosition = mainSquare.position.x + CGFloat(columnIndex * AppConstants.UILayout.BoardSquareEdgeLength)
            var yPosition = mainSquare.position.y + CGFloat(rowIndex * AppConstants.UILayout.BoardSquareEdgeLength)
            
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
            
            if (lastSelectedDragStack != nil) {
                var newX = location.x - CGFloat((AppConstants.UILayout.BoardSquareEdgeLength / 2))
                var newY = location.y //- CGFloat((AppConstants.UILayout.BoardSquareEdgeLength / 4))
                lastSelectedDragStack!.position = CGPointMake(newX, newY)
            }
            break
        }
    }
    
    var lastSelectedCircle : SKShapeNode? = nil;
    var selectedCircleInitialPosition : CGPoint? = nil;
    var lastSelectedGridSquare : GridSquare? = nil;
    var lastSelectedDragStack : DragStack? = nil;
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            for node in self.nodesAtPoint(location) {
                if let gridSquare = node as? GridSquare {
                    if (gridSquare.getGamePieces().count > 0) {
                        lastSelectedGridSquare = gridSquare;
                        var dragStack = gridSquare.getDragStack()!;
                        lastSelectedDragStack = dragStack;

                        var newX = location.x - CGFloat((AppConstants.UILayout.BoardSquareEdgeLength / 2))
                        var newY = location.y //- CGFloat((AppConstants.UILayout.BoardSquareEdgeLength / 4))
                        

                        dragStack.position = CGPointMake(newX, newY)
                        self.addChild(dragStack);
                        
                        var startDragNoise = SKAction.playSoundFileNamed("Item1A.wav", waitForCompletion: false)
                        self.runAction(startDragNoise)
                        
                        
//                        
//                        var newX1 = mainSquare.position.x + location.x - CGFloat((AppConstants.UILayout.BoardSquareEdgeLength / 2))
//                        var newY1 = mainSquare.position.y + location.y //- CGFloat((AppConstants.UILayout.BoardSquareEdgeLength / 4))
//                        var newStartPoint = CGPointMake(newX1, newY1)
//                        = newStartPoint
//                        
//                                                var moveToPoint = SKAction.moveTo(CGPointMake(newX, newY), duration:0.2)
//
                        
                     
                       // dragStack.runAction(moveToPoint)

                    }
                }
            }
            
            break
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        // TODO Move selected circle to proper position.
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)

            var targetGridSquare : GridSquare? = nil;
            
            // Try to drop the drag stack on the current square. Do this by determining if we're
            // over a grid square, and whether the square will accept the stack.
            if (lastSelectedDragStack != nil) {
                for node in self.nodesAtPoint(location) {
                    if (node is GridSquare) {
                        var gridSquare = node as! GridSquare;
                        if (!gridSquare.IsInventorySquare) {
                            if (gridSquare.canAddDragStack(lastSelectedDragStack!)) {
                                targetGridSquare = gridSquare
                            }
                        }
                    }
                }
                
            }
            
            // If we a dropping on a valid square, complete the operation. Else, return the stack to where it started.
            if (targetGridSquare != nil) {
                
                for gamePiece in lastSelectedGridSquare!.getGamePieces().reverse() {
                    if (gamePiece.userData != nil && gamePiece.userData?.objectForKey("x") != nil) {
                        lastSelectedGridSquare!.tryRemoveGamePiece(gamePiece)
                    }
                    
                }
                
                
                targetGridSquare!.tryAddDragStack(lastSelectedDragStack!)
 
                
                
                
                if (targetGridSquare!.getGamePieces().count  == 5) {
                    // We've made a stack of 5. Score a point.
                    
                    for gamePiece in targetGridSquare!.getGamePieces().reverse() {
                        
                            targetGridSquare!.tryRemoveGamePiece(gamePiece)
                        
                    }
                    
                    
                    
                    self.addToScore(1)
                    var startDragNoise = SKAction.playSoundFileNamed("Menu1A.wav", waitForCompletion: false)
                    self.runAction(startDragNoise)

                } else {
//                    var startDragNoise = SKAction.playSoundFileNamed("Item1B.wav", waitForCompletion: false)
//                    self.runAction(startDragNoise)

                }
                
                
            } else if (lastSelectedGridSquare != nil) {
                
                for gamePiece in lastSelectedGridSquare!.getGamePieces() {
                    gamePiece.alpha = 1.0
                }
                
                for gamePiece in lastSelectedDragStack!.getGamePieces() {
                    gamePiece.removeFromParent()
                }
                lastSelectedDragStack?.removeFromParent()
            }
            
            break
        }
        
        lastSelectedDragStack?.removeFromParent()

        
        lastSelectedGridSquare = nil;
        lastSelectedDragStack = nil;


        // Clean up inventory.
        
        for columnIndex in 0..<columnCount {
            var inventorySquare = self.InventorySquares[columnIndex]
            if (inventorySquare.getGamePieces().count == 0) {
                // Look ahead for the next square with pieces.
                for altColumnIndex in (columnIndex + 1)..<columnCount {
                    var altInventorySquare = self.InventorySquares[altColumnIndex]
                    if (altInventorySquare.getGamePieces().count > 0) {
                        inventorySquare.tryAddDragStack(altInventorySquare.getDragStack()!)
                        break
                    }
                }
            }
        }
        
        // Add another piece, if possible.
        for columnIndex in 0..<columnCount {
            var inventorySquare = self.InventorySquares[columnIndex]
            if (inventorySquare.getGamePieces().count == 0) {
                var pieceValue = Int(arc4random_uniform(5) + 1)
                inventorySquare.tryAddGamePiece( GamePiece(pieceValue: pieceValue))
                break
            }
        }
    }
  
    func addToScore(points: Int) {
        
        self.score += points
        scoreLabel.text = String(self.score)
        
        if (points > 0) {
            
            var grow = SKAction.scaleTo( 2.0, duration: 0.2)

            var group1 = SKAction.group([grow])
            
            var shrink = SKAction.scaleTo (1.0, duration: 0.5)

            var group2 = SKAction.group([shrink])
            
            var actions = SKAction.sequence([group1, group2])
            scoreLabel.runAction(actions)
        }

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
