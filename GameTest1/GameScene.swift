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
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 65
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        //self.addChild(myLabel)
        
        
        createTileGrid()
        //demo()
    }
    
    func createTileGrid() {
        
        let rowCount = 5
        let columnCount = 6
        let gridSquareEdgeLength = 100
        let mainSquareWidth = columnCount * gridSquareEdgeLength
        let mainSquareHeight = rowCount * gridSquareEdgeLength
        
        let mainSquare = SKSpriteNode()
        mainSquare.size = CGSize(width: mainSquareWidth , height: mainSquareHeight)
        mainSquare.anchorPoint = CGPointMake(0,0)
        mainSquare.position = CGPoint(x:CGRectGetMidX(self.frame) - CGFloat(mainSquareWidth / 2),
            y:CGRectGetMidY(self.frame) - CGFloat(mainSquareHeight / 2))
        mainSquare.color = UIColor.redColor()
        
        mainSquare.physicsBody?.dynamic = false
        mainSquare.physicsBody?.collisionBitMask = 0x0;
        mainSquare.physicsBody?.contactTestBitMask = 0x0;


        
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

    }
    
    
    
    func makeRedBox(size: CGSize) -> SKSpriteNode {
        var node = SKSpriteNode()
        node.color = UIColor.redColor()
        node.size = size;
        return node;
    }
    func makeGreenBox(size: CGSize) -> SKSpriteNode {
        var node = SKSpriteNode()
        node.color = UIColor.greenColor()
        node.size = size;
        return node;
    }
    func makeBlueBox(size: CGSize) -> SKSpriteNode {
        var node = SKSpriteNode()
        node.color = UIColor.blueColor()
        node.size = size;
        return node;
    }
   
    
    func demo() {
        var box1 = self.makeRedBox(CGSizeMake(200, 200));
        box1.anchorPoint = CGPointMake(0,0);
        box1.position = CGPoint(x:CGRectGetMidX(self.frame) - 100, y:CGRectGetMidY(self.frame) - 100)
        
        var box2 =  makeBlueBox(CGSizeMake(100, 100));
        box2.anchorPoint = CGPointMake(0,0);
        box2.position = CGPointMake(0,0);
        box1.addChild(box2)
            
        var box3 =  makeGreenBox(CGSizeMake(25, 25));
        box3.anchorPoint = CGPointMake(0,0);
        box3.position = CGPointMake(0,0);
        box2.addChild(box3)
        
        self.addChild(box1)
    }
    
    var lastSelectedNode : SKSpriteNode? = nil;
    var lastSelectedColor : UIColor? = nil;
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            self.doNodeColorChange(location)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            self.doNodeColorChange(location)
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.revertLastSelectedNode();
    }
    
    func doNodeColorChange(location: CGPoint) {
        // Find the node at the touch postion, if one exists.
        
        var currentNode = self.nodeAtPoint(location) as? SKSpriteNode
        
        if (currentNode != nil) {
            
            
            if (currentNode!.name != gridSquareName) {
                // If the current node isn't a gridSquareNode, then the only possible
                // thing to do is reset the node's color, as long as lastSelectedNode
                // isn't nil
                
                revertLastSelectedNode()
            } else {
                // Either the lastSelectedNode is nil or it's set to something.
                // If it's nil, we don't worry about it,
                // If it's something, and different from the current node, we revert it.
                
                if (currentNode != lastSelectedNode) {
                    revertLastSelectedNode()
                    
                    self.lastSelectedNode = currentNode
                    self.lastSelectedColor = currentNode!.color
                    currentNode!.color = UIColor.purpleColor()
                    
                }
            }
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
