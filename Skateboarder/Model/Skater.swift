//
//  Skater.swift
//  Skateboarder
//
//  Created by Nikolay Tkachenko on 27.07.2020.
//  Copyright © 2020 Nikolay Tkachenko. All rights reserved.
//

import UIKit
import SpriteKit

class Skater: SKSpriteNode {
    
    var velocity = CGPoint.zero
    var minimumY: CGFloat = 0.0
    var jumpSpeed: CGFloat = 20.0
    var isInGround = true
    
    func setupPhisicsBody(){
        if let skateTexture = texture {
            physicsBody = SKPhysicsBody(texture: skateTexture, size: size)
            physicsBody?.isDynamic = true
            physicsBody?.density = 6.0
            //physicsBody?.allowsRotation = true
            physicsBody?.allowsRotation = false
            physicsBody?.angularDamping = 1.0
            
            physicsBody?.categoryBitMask = PhysicsCategory.skater
            physicsBody?.collisionBitMask = PhysicsCategory.brick
            physicsBody?.contactTestBitMask = PhysicsCategory.brick | PhysicsCategory.gem
        }
    }
    
    func createSparks(){
        let bundle = Bundle.main
        
        if let sparksPath = bundle.path(forResource: "sparks", ofType: "sks"){
            let sparksNode = NSKeyedUnarchiver.unarchiveObject(withFile: sparksPath) as! SKEmitterNode
            sparksNode.position = CGPoint(x: 0.0, y: -50.0)
            addChild(sparksNode)
            
            let waitAction = SKAction.wait(forDuration: 0.5)
            let removeAction = SKAction.removeFromParent()
            let waiotThenRemove = SKAction.sequence([waitAction, removeAction])
            sparksNode.run(waiotThenRemove)
        }
        
    }

}
