//
//  SpriteUtils.swift
//  GameTest1
//
//  Created by Dan on 6/2/15.
//  Copyright (c) 2015 Dan. All rights reserved.
//

import Foundation
import SpriteKit

public class SpriteUtils {
    
    public static func DisableNodePhysics(node: SKNode) {
        node.physicsBody?.dynamic = false
        node.physicsBody?.collisionBitMask = 0x0;
        node.physicsBody?.contactTestBitMask = 0x0;
    }
}