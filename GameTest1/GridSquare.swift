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
        
        private var GamePieces : [GamePiece]!
        
            
        override init(texture: SKTexture!, color: SKColor!, size: CGSize) {
            super.init(texture: texture, color: color, size: size)
        }
        
        public convenience init(rowIndex: Int, columnIndex: Int) {
            var size = CGSizeMake(CGFloat(AppConstants.UILayout.BoardSquareEdgeLength), CGFloat(AppConstants.UILayout.BoardSquareEdgeLength))
            
            self.init(texture:nil, color: UIColor.greenColor(), size: size)
            
            self.RowIndex = rowIndex
            self.ColumnIndex = columnIndex
            self.GamePieces = [GamePiece]()
            
            let colorKey = RowIndex % 2 + ColumnIndex % 2
            
            // Alternate every color, but switch the alternation for each row. (That is, a checkerboard.)
            self.color = colorKey % 2 == 0 ? UIColor.blueColor() : UIColor.brownColor()
            self.size = size
            self.anchorPoint = CGPointMake(0,0);
            self.position = CGPoint(x: (AppConstants.UILayout.BoardSquareEdgeLength) * columnIndex, y: (AppConstants.UILayout.BoardSquareEdgeLength) * rowIndex);
            
            SpriteUtils.DisableNodePhysics(self)

        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        
        
        private func addGamePiece(gamePiece: GamePiece) {
            assert(canAddGamePiece(gamePiece), "Game piece may not be added.")
            
            self.GamePieces.append(gamePiece);
            
            // TODO: Visualization
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
                self.addGamePiece(gamePiece);
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
                return true;            
            }
        }
        
    }
