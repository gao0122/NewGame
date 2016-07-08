//
//  Main.swift
//  Don't Drop Me!
//
//  Created by 高宇超 on 7/6/16.
//  Copyright © 2016 Yuchao. All rights reserved.
//

import SpriteKit

class Main: SKScene {
    
    var buttonPlay: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        buttonPlay = childNodeWithName("buttonPlay") as! SKLabelNode
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let node = nodeAtPoint(touch.locationInNode(self))
            if node.name == "buttonPlay" {
                let scene = Level(fileNamed:"Level") as Level!
                let skView = self.view as SKView!
                skView.showsFPS = true
                skView.showsNodeCount = true
                skView.showsPhysics = true
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .AspectFit
                
                skView.presentScene(scene)
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
}