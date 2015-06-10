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
        public var RowIndex : Int!
        public var ColumnIndex : Int!
        public var IsInventorySquare : Bool!;
        
        private var GamePieces : [GamePiece]!
        

        
            
        override init(texture: SKTexture!, color: SKColor!, size: CGSize) {
            super.init(texture: texture, color: color, size: size)
            SpriteUtils.DisableNodePhysics(self);
        }
        
        public convenience init(rowIndex: Int, columnIndex: Int, isInventorySquare: Bool) {
            var size = CGSizeMake(CGFloat(AppConstants.UILayout.BoardSquareEdgeLength), CGFloat(AppConstants.UILayout.BoardSquareEdgeLength))
            
            self.init(texture:nil, color: UIColor.greenColor(), size: size)
            
            self.RowIndex = rowIndex
            self.ColumnIndex = columnIndex
            self.IsInventorySquare = isInventorySquare;
            self.GamePieces = [GamePiece]()
            
            let colorKey = RowIndex % 2 + ColumnIndex % 2
            
            // Alternate every color, but switch the alternation for each row. (That is, a checkerboard.)
            self.color = self.IsInventorySquare! ? (colorKey % 2 == 0 ? UIColor.darkGrayColor() : UIColor.grayColor())
                : (colorKey % 2 == 0 ? UIColor.blueColor() : UIColor.brownColor())
            self.size = size
            self.anchorPoint = CGPointMake(0,0);
            self.position = CGPoint(x: (AppConstants.UILayout.BoardSquareEdgeLength) * columnIndex, y: (AppConstants.UILayout.BoardSquareEdgeLength) * rowIndex);
            
            SpriteUtils.DisableNodePhysics(self)

        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        
        public func canAddGamePiece(gamePiece: GamePiece) -> Bool {
            // The piece can be added as long as either the square either has no pieces in it
            // or the top-most piece has a larger value than the incoming tile.
            return self.GamePieces.count == 0
                || self.GamePieces[self.GamePieces.count - 1].PieceValue > gamePiece.PieceValue;
            
        }
        
        public func tryAddGamePiece(gamePiece: GamePiece) -> Bool {
            if (!canAddGamePiece(gamePiece)) {
                return false;
            } else {
                self.GamePieces.append(gamePiece);
                // TODO: Visualization
                
                self.addChild(gamePiece)
                
                refreshGamePiecePositions();
                return true;
            }
        }
        
        public func getGamePieces() -> [GamePiece] {
            return self.GamePieces;
        }
        
        public func canRemoveGamePiece(gamePiece: GamePiece) -> Bool {
            // The piece can be removed as long as it exists in the collection, and is the last
            // element in the collection.
            var index = find(self.GamePieces, gamePiece);
            return index != nil
                && index! == self.GamePieces.count - 1
            
        }

        
        /**
            Removes the given game piece, if it exists in the collection. Returns a boolean indicating whether it remove the piece.
        */
        public func tryRemoveGamePiece(gamePiece: GamePiece ) -> Bool {
            if (!canRemoveGamePiece(gamePiece)) {
                return false;
            } else {
                self.GamePieces.removeAtIndex(find(self.GamePieces, gamePiece)!);
                                
                gamePiece.removeFromParent()

                self.refreshGamePiecePositions()
                return true;            
            }
        }
        
        private func refreshGamePiecePositions() {
            for tuple in SpriteUtils.GetGamePiecePositions(self.GamePieces) {
                tuple.gamePiece.position = tuple.position
            }
        }
        
        
        public func getDragStack() -> DragStack? {
            if (self.GamePieces.count ==  0) {
                return nil;
            }
            
            
            // The drag stack contains the top item in the stack, as well as all other
            // consecutive items. They need to be removed from the GamePieces list.
            
            // Get the consecutive items starting from the top of the stack.
            var topOfStack = [GamePiece]()
            var firstPiece = self.GamePieces[self.GamePieces.count - 1]
            firstPiece.alpha = 0.5
            firstPiece.userData = NSMutableDictionary()
            firstPiece.userData?.setValue("x", forKey: "x")
            var newFirstPiece = GamePiece(pieceValue: firstPiece.PieceValue);
            topOfStack.append(newFirstPiece);
            var lastPieceValue = firstPiece.PieceValue;
            
            for (var index = self.GamePieces.count - 2; index >= 0; index--) {
                var gamePiece = self.GamePieces[index]
                if (gamePiece.PieceValue - 1 == lastPieceValue) {
                    // This is a consecutive piece. Add it.
                    var copyOfPiece = GamePiece(pieceValue: gamePiece.PieceValue)
                    topOfStack.insert(copyOfPiece, atIndex: 0);
                    lastPieceValue = gamePiece.PieceValue;
                    
                    // Make the current piece semi-transparent. 
                    gamePiece.alpha = 0.5
                    gamePiece.userData = NSMutableDictionary()
                    gamePiece.userData?.setValue("x", forKey: "x")
                    
                } else {
                    // Not consecutive. Break out of the loop.
                    break;
                }
            }
            
            
            var dragStack = DragStack(gamePieces: topOfStack);
            
            
            return dragStack;            
        }
        
        public func canAddDragStack(dragStack: DragStack) -> Bool {
            // if drag stack's max pieceValue is greater than this square's min piece value,
            // allow the stack.
            var dragStackMaxPieceValue = sorted(dragStack.getGamePieces(), {p1, p2 in return p1.PieceValue > p2.PieceValue}).first?.PieceValue
//            
//            var ownGamePieces = self.GamePieces.filter({ $0.userData = nil || $0.userData!.objectForKey("x") == nil })
//            var gridSquareMinPieceValue = sorted(ownGamePieces, {p1, p2 in return p1.PieceValue < p2.PieceValue}).first?.PieceValue ?? Int.max
            
            var ownGamePieces = self.getGamePieces().filter({$0.userData == nil
                || $0.userData!.objectForKey("x") == nil })

            var gridSquareMinPieceValue = sorted(ownGamePieces, {p1, p2 in return p1.PieceValue < p2.PieceValue}).first?.PieceValue ?? Int.max

            
            return dragStackMaxPieceValue < gridSquareMinPieceValue
        }
        
        public func tryAddDragStack(dragStack: DragStack) -> Bool {
            if (!canAddDragStack(dragStack)) {
                return false;
            }
            
            // Take all the pieces out of the stack and place them into the gridSquare. 
            for gamePiece in sorted(dragStack.getGamePieces(), {p1, p2 in return p1.PieceValue > p2.PieceValue}) {
                gamePiece.removeFromParent()
                self.tryAddGamePiece(gamePiece)
                
                // No need to remove the pieces from the drag stack. It will soon go out of scope and be disposed.
            }
            
            return true;
        }
        
    }
