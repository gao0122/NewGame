//
//  Bounce.swift
//  Don't Drop Me!
//
//  Created by 高宇超 on 7/7/16.
//  Copyright © 2016 Yuchao. All rights reserved.
//

import SpriteKit

class Bounce: SKNode {
    
    var k: CGFloat = 0.5
    var obj0: SKNode!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    init(node: SKNode, scene: GameScene) {
        obj0 = node.childNodeWithName("obj0")!
        super.init()
        obj0.removeFromParent()
        addChild(obj0)
        scene.addChild(self)
        userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}