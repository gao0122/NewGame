//
//  GameScene.swift
//  Don't Drop Me!
//
//  Created by 高宇超 on 7/5/16.
//  Copyright (c) 2016 Yuchao. All rights reserved.
//

import SpriteKit

enum GameState {
    case Ready, Playing, Dropping, GameOver
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var state: GameState = .Ready
    
    var levelNode: SKNode!
    var startNode: SKSpriteNode!
    var endNode: SKSpriteNode!
    var nowNode: SKSpriteNode?
    
    var ballNode: Ball!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.view?.showsPhysics = true
        self.view?.multipleTouchEnabled = true
        physicsWorld.contactDelegate = self
        
        // node connection
        levelNode = self.childNodeWithName("levelNode")
        if levelNode.children.count == 0 {
            let levelPath = NSBundle.mainBundle().pathForResource("Level0", ofType: "sks")
            let newLevel = SKReferenceNode(URL: NSURL(fileURLWithPath: levelPath!))
            levelNode.addChild(newLevel)
        }
        startNode = self.childNodeWithName("//start") as! SKSpriteNode
        endNode = self.childNodeWithName("//end") as! SKSpriteNode
        
        ballNode = self.childNodeWithName("ball") as! Ball
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */

        ballNode.physicsBody?.dynamic = true

        print("touches began is ")
        let count = touches.count
        switch count {
        case 1:
            for touch in touches {
                let location = touch.locationInNode(self)
                let node = nodeAtPoint(location)
                if node.name! != "bg" {
                    
                }
            }
        case 2:
            for touch in touches {
                let location = touch.locationInNode(self)
                print(location)
            }
        default:
            break
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touches moved is ")

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touches ended is ")

    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        print("touches cancelled is ")

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        print(ballNode.position)
        if isBallInArea(ballNode.position, isStart: false, node: endNode) {
            ballNode.physicsBody?.dynamic = false
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let contactA: SKPhysicsBody = contact.bodyA
        let contactB: SKPhysicsBody = contact.bodyB
        
        let nodeA = contactA.node as! SKSpriteNode
        let nodeB = contactB.node as! SKSpriteNode

        let categoryA = contactA.categoryBitMask
        let categoryB = contactB.categoryBitMask
        
        print("\ncontact \(nodeA.name) \(nodeB.name)")
        
        // simple bounce
        if categoryA == 1 && categoryB == 2 {
            print("here A \(contactB.node?.name!)")
            let bounceNode = Bounce(node: childNodeWithName("//\(contactB.node?.name as String!)")!, scene: self)
            contactA.applyImpulse(contact.contactNormal * contact.collisionImpulse * bounceNode.k)
        } else if categoryB == 1 && categoryA == 2 {
            print("here B \(contactA.node?.name as String!)")
            let bounceNode = Bounce(node: childNodeWithName("//\(contactA.node?.name as String!)")!, scene: self)
            contactB.applyImpulse(contact.contactNormal * contact.collisionImpulse * bounceNode.k)
        }
        

    }
    
    func isBallInArea(pos: CGPoint, isStart: Bool, node: SKSpriteNode) -> Bool {
        let xL = node.position.x - node.size.width / 2 + 32//(isStart ? 16 : -16)
        let xR = node.position.x + node.size.width / 2 //(isStart ? -16 : 16)
        let yU = node.position.y + node.size.height / 2 //(isStart ? -16 : 16)
        let yD = node.position.y - node.size.height / 2 + 32//(isStart ? 16 : -16)
        
        return xL < pos.x && xR > pos.x && yU > pos.y && yD < pos.y
    }
    
    func addBallAtLocation(location: CGPoint) -> Void {
        if isBallInArea(location, isStart: true, node: startNode) {
            
        }
    }
    
}
