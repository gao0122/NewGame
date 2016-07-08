//
//  Level.swift
//  Don't Drop Me!
//
//  Created by 高宇超 on 7/6/16.
//  Copyright © 2016 Yuchao. All rights reserved.
//

import SpriteKit

class Level: SKScene {
    
    var chosen = false
    
    let levelNum = 4
    var levels = [Int: SKLabelNode!]()
    
    override func didMoveToView(view: SKView) {
        for n in 0..<levelNum {
            levels[n] = self.childNodeWithName("level\(n)") as! SKLabelNode
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if chosen {
            return
        }
        for touch in touches {
            let node = nodeAtPoint(touch.locationInNode(self))
            for n in 0..<levelNum {
                if node.name == "level\(n)" {
                    let path = NSBundle.mainBundle().pathForResource("Level\(n)", ofType: "sks")
                    let newLevel = SKReferenceNode(URL: NSURL(fileURLWithPath: path!))
                    let scene = GameScene(fileNamed:"GameScene") as GameScene!
                    let skView = self.view as SKView!

                    skView.showsFPS = true
                    skView.showsNodeCount = true
                    skView.showsPhysics = true
                    
                    /* Set the scale mode to scale to fit the window */
                    scene.scaleMode = .AspectFit
                    scene.childNodeWithName("levelNode")?.addChild(newLevel)
                    skView.presentScene(scene)
                    chosen = true
                    break
                }
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
}
