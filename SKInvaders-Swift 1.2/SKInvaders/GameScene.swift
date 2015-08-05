//
//  GameScene.swift
//  SKInvaders
//
//  Created by Riccardo D'Antoni on 15/07/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate
{
  //MARK: - Private GameScene Properties
    
    let kInvaderCategory: UInt32 = 0x1 << 0
    let kShipFireBulletCategory: UInt32 = 0x1 << 1
    let kShipCategory:UInt32 = 0x1 << 2
    let kSceneEdgeCategory:UInt32 = 0x1 << 3
    let kInvaderFireBulletCategory: UInt32 = 0x1 << 4
  
    var contentCreated = false
    
    enum InvaderType
    {
        case A
        case B
        case C
    }
    
    enum InvaderMovementDirection
    {
        case Right
        case Left
        case DownThenRight
        case DownThenLeft
        case None
    }
    
    enum BulletType
    {
        case ShipFired
        case InvaderFired
    }
    
    let motionManager: CMMotionManager = CMMotionManager()
    var tapQueue: Array<Int> = []
    var contactQueue: Array<SKPhysicsContact> = []
    
    let kInvaderSize = CGSize(width: 24, height: 16)
    let kInvaderGridSpacing = CGSize (width: 12, height: 12)
    let kInvaderRowCount = 6
    let kInvaderColCount = 6
    
    let kInvaderName = "invader"
    
    let kShipSize = CGSize(width: 30, height: 16)
    let kShipName = "ship"
    
    let kScoreHudName = "scoreHud"
    let kHealthHudName = "healthHud"
    
    var invaderMovementDirection: InvaderMovementDirection = .Right
    var timeOfLastMove: CFTimeInterval = 0.0
    var timePerMove: CFTimeInterval = 1.0
    
    let kMinInvaderBottomHeight: Float = 32.0
    var gameEnding: Bool = false
    
    let kShipFiredBulletName = "shipFiredBullet"
    let kInvaderFiredBulletName = "invaderFiredBullet"
    let kBulletSize = CGSize(width: 4.0, height: 8.0)
    
    var score: Int = 0
    var shipHealth: Float = 1.0
  
  //MARK: - Object Lifecycle Management
  
  //MARK: - Scene Setup and Content Creation
    
  override func didMoveToView(view: SKView)
  {
    
        if (!self.contentCreated)
        {
          self.createContent()
          self.contentCreated = true
          motionManager.startAccelerometerUpdates()
          userInteractionEnabled = true
          physicsWorld.contactDelegate = self
        }
  }
  
  func createContent()
  {
    
//    let invader = SKSpriteNode(imageNamed: "InvaderA_00.png")
//    
//    invader.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
//    
//    self.addChild(invader)
    
    physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
    physicsBody!.categoryBitMask = kSceneEdgeCategory
    
    setUpInvaders()
    setUpShip()
    setUpHud()
    
    // black space color
    self.backgroundColor = SKColor.blackColor()
  }
    
    func loadInvaderTexturesOfType(invaderType: InvaderType) -> Array<SKTexture>
    {
        var prefix: String
        switch invaderType
        {
        case .A:
            prefix = "InvaderA"
        case .B:
            prefix = "InvaderB"
        case .C:
            prefix = "InvaderC"
        default:
            prefix = "InvaderC"
        }
        
        return [SKTexture(imageNamed: String(format: "%@_00.png", prefix)), SKTexture(imageNamed: String(format: "%@_01.png",  prefix))]
    }
    
    func makeInvaderOfType(invaderType: InvaderType) -> (SKNode)
    {
        let invaderTextures = loadInvaderTexturesOfType(invaderType)
        let invader = SKSpriteNode(texture: invaderTextures[0])
        invader.name = kInvaderName
        
        invader.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(invaderTextures, timePerFrame: timePerMove)))
        
        invader.physicsBody = SKPhysicsBody(rectangleOfSize: invader.frame.size)
        invader.physicsBody!.dynamic = false
        invader.physicsBody!.categoryBitMask = kInvaderCategory
        invader.physicsBody!.contactTestBitMask = 0x0
        invader.physicsBody!.collisionBitMask = 0x0
        
        
        return invader
    }
    
    func setUpInvaders()
    {
            let baseOrigin = CGPoint(x: size.width / 3, y: 180)
            for var row = 1; row <= kInvaderRowCount; row++
            {
                var invaderType: InvaderType
                if row % 3 == 0
                {
                    invaderType = .A
                }
                else if row % 3 == 1
                {
                    invaderType = .B
                }
                else
                {
                    invaderType = .C
                }
                
                let invaderPositionY = CGFloat(row) * kInvaderSize.height * 2 + baseOrigin.y
                var invaderPosition = CGPoint(x: baseOrigin.x, y: invaderPositionY)
                
                for var col = 1; col <= kInvaderColCount; col++
                {
                    var invader = makeInvaderOfType(invaderType)
                    invader.position = invaderPosition
                    addChild(invader)
                    
                    invaderPosition = CGPoint(x: invaderPosition.x + kInvaderSize.width + kInvaderGridSpacing.width, y: invaderPositionY)
                }
            }
    }
    
    func setUpShip()
    {
        let ship = makeShip()
        
        ship.position = CGPoint(x: size.width / 2.0, y: kShipSize.height / 2.0)
        addChild(ship)
    }
    
    func makeShip() -> SKNode
    {
        let ship = SKSpriteNode(imageNamed: "Ship.png")
        ship.name = kShipName
        ship.physicsBody = SKPhysicsBody(rectangleOfSize: ship.frame.size)
        ship.physicsBody!.dynamic = true
        ship.physicsBody!.affectedByGravity = false
        ship.physicsBody!.mass = 0.02
        ship.physicsBody!.categoryBitMask = kShipCategory
        ship.physicsBody!.contactTestBitMask = 0x0
        ship.physicsBody!.collisionBitMask = kSceneEdgeCategory
        
        return ship
    }
    
    func setUpHud()
    {
        let scoreLabel = SKLabelNode(fontNamed: "Courier")
        scoreLabel.name = kScoreHudName
        scoreLabel.fontSize = 25
        scoreLabel.fontColor = SKColor.greenColor()
        scoreLabel.text = String(format: "Score: %04u", 0)
        
        scoreLabel.position = CGPoint(x: frame.size.width / 2, y: size.height - (40 + scoreLabel.frame.size.height / 2))
        addChild(scoreLabel)
        
        let healthLabel = SKLabelNode(fontNamed: "Courier")
        healthLabel.name = kHealthHudName
        healthLabel.fontSize = 25
        healthLabel.fontColor = SKColor.redColor()
        healthLabel.text = String(format: "Health: %.1f%%", shipHealth * 100.0)
        
        healthLabel.position = CGPoint(x: frame.size.width / 2, y: size.height - (80 + healthLabel.frame.size.height / 2))
        addChild(healthLabel)
    }
    
    func makeBulletOfType(bulletType: BulletType) -> SKNode!
    {
        var bullet: SKNode!
        
        switch bulletType
        {
        case .ShipFired:
            bullet = SKSpriteNode(color: SKColor.greenColor(), size: kBulletSize)
            bullet.name = kShipFiredBulletName
            bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.frame.size)
            bullet.physicsBody!.dynamic = true
            bullet.physicsBody!.affectedByGravity = false
            bullet.physicsBody!.categoryBitMask = kShipFireBulletCategory
            bullet.physicsBody!.contactTestBitMask = kInvaderCategory
            bullet.physicsBody!.collisionBitMask = 0x0
        case .InvaderFired:
            bullet = SKSpriteNode(color: SKColor.magentaColor(), size: kBulletSize)
            bullet.name = kInvaderFiredBulletName
            bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.frame.size)
            bullet.physicsBody!.dynamic = true
            bullet.physicsBody!.affectedByGravity = false
            bullet.physicsBody!.categoryBitMask = kInvaderFireBulletCategory
            bullet.physicsBody!.contactTestBitMask = kShipCategory
            bullet.physicsBody!.collisionBitMask = 0x0
        default:
            bullet = nil
        }
        return bullet
    }
   
  //MARK: - Scene Update
  
  override func update(currentTime: CFTimeInterval)
  {
    /* Called before each frame is rendered */
    if isGameOver()
    {
        endGame()
    }
    processContactsForUpdate(currentTime)
    moveInvadersForUpdate(currentTime)
    processUserMotionForUpdate(currentTime)
    processUserTapsForUpdate(currentTime)
    fireInvaderBulletsForUpdate(currentTime)
  }
  
  
  //MARK: - Scene Update Helpers
    
    func moveInvadersForUpdate(currentTime: CFTimeInterval)
    {
        if (currentTime - timeOfLastMove < timePerMove)
        {
            return
        }
        
        determineInvaderMovementDirection()
        
        enumerateChildNodesWithName(kInvaderName) {
            node, stop in
                switch self.invaderMovementDirection
                {
                case .Right:
                    node.position = CGPoint(x: node.position.x + 10, y: node.position.y)
                case .Left:
                    node.position = CGPoint(x: node.position.x - 10, y: node.position.y)
                case .DownThenLeft, .DownThenRight:
                    node.position = CGPoint(x: node.position.x, y: node.position.y - 10)
                case .None:
                    break
                default:
                    break
                }
                self.timeOfLastMove = currentTime
            }
    }
    
    func processUserMotionForUpdate(currentTime: CFTimeInterval)
    {
        if let ship = childNodeWithName(kShipName) as? SKSpriteNode
        {
            if let data = motionManager.accelerometerData
            {
                if fabs(data.acceleration.x) > 0.2
                {
                    ship.physicsBody!.applyForce(CGVectorMake(40.0 * CGFloat(data.acceleration.x), 0.0))
                }
            }
        }
    }
    
    func processUserTapsForUpdate(currentTime: CFTimeInterval)
    {
        for tapCount in tapQueue
        {
            if tapCount == 1
            {
                fireShipBullets()
            }
            tapQueue.removeAtIndex(0)
        }
    }
    
    func fireInvaderBulletsForUpdate(currentTime: CFTimeInterval)
    {
        let existingBullet = childNodeWithName(kInvaderFiredBulletName)
        
        if existingBullet == nil
        {
            var allInvaders = Array<SKNode>()
            enumerateChildNodesWithName(kInvaderName) {
                node, stop in
                allInvaders.append(node)
            }
            
            if allInvaders.count > 0
            {
                let allInvadersIndex = Int(arc4random_uniform(UInt32(allInvaders.count)))
                let invader = allInvaders[allInvadersIndex]
                let bullet = makeBulletOfType(.InvaderFired)
                bullet.position = CGPoint(x: invader.position.x, y: invader.position.y - invader.frame.size.height / 2 + bullet.frame.size.height / 2)
                let bulletDestination = CGPoint(x: invader.position.x, y: -(bullet.frame.size.height / 2))
                fireBullet(bullet, toDestination: bulletDestination, withDuration: 1.0, andSoundFileName: "InvaderBullet.wav")
            }
        }
    }
    
    func processContactsForUpdate(currentTime: CFTimeInterval)
    {
        for contact in contactQueue
        {
            handleContact(contact)
            if let index = (contactQueue as NSArray).indexOfObject(contact) as Int?
            {
                contactQueue.removeAtIndex(index)
            }
        }
    }
  
  //MARK: - Invader Movement Helpers
    
    func determineInvaderMovementDirection()
    {
        var proposeMovementDirection: InvaderMovementDirection = invaderMovementDirection
        
        enumerateChildNodesWithName(kInvaderName) {
            node, stop in
            switch self.invaderMovementDirection
            {
            case .Right:
                if (CGRectGetMaxX(node.frame) >= node.scene!.size.width - 1.0)
                {
                    proposeMovementDirection = .DownThenLeft
                    self.adjustInvaderMovementToTimePerMove(self.timePerMove * 0.8)
                    stop.memory = true
                }
            case .Left:
                if (CGRectGetMinX(node.frame) <= 1.0)
                {
                    proposeMovementDirection = .DownThenRight
                    self.adjustInvaderMovementToTimePerMove(self.timePerMove * 0.8)
                    stop.memory = true
                }
            case .DownThenLeft:
                proposeMovementDirection = .Left
                stop.memory = true
            case .DownThenRight:
                proposeMovementDirection = .Right
                stop.memory = true
            default:
                break
            }
        }
        if proposeMovementDirection != invaderMovementDirection
        {
            invaderMovementDirection = proposeMovementDirection
        }
    }
    
    func adjustInvaderMovementToTimePerMove(newTimePerMove: CFTimeInterval)
    {
        if newTimePerMove <= 0
        {
            return
        }
        
        let ratio: CGFloat = CGFloat(timePerMove / newTimePerMove)
        timePerMove = newTimePerMove
        
        enumerateChildNodesWithName(kInvaderName) {
            node, stop in
            node.speed = node.speed * ratio
        }
    }
  
  //MARK: - Bullet Helpers
    
    func fireBullet(bullet: SKNode, toDestination destination: CGPoint, withDuration duration:CFTimeInterval, andSoundFileName soundName: String)
    {
        let bulletAction = SKAction.sequence([SKAction.moveTo(destination, duration: duration), SKAction.waitForDuration(3.0/60.0), SKAction.removeFromParent()])
        let soundAction = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)
        bullet.runAction(SKAction.group([bulletAction, soundAction]))
        self.addChild(bullet)
    }
    
    func fireShipBullets()
    {
        let existingBullet = self.childNodeWithName(kShipFiredBulletName)
        if existingBullet == nil
        {
            if let ship = childNodeWithName(kShipName)
            {
                if let bullet = makeBulletOfType(.ShipFired)
                {
                    bullet.position = CGPoint(x: ship.position.x, y:ship.position.y + ship.frame.size.height - bullet.frame.size.height / 2)
                    let bulletDestination = CGPoint(x: ship.position.x, y: self.frame.size.height + bullet.frame.size.height / 2)
                    fireBullet(bullet, toDestination: bulletDestination, withDuration: 0.5, andSoundFileName: "ShipBullet.wav")
                }
            }
        }
    }
  
  //MARK: - User Tap Helpers
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        // Intentional no-op
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        // Intentional no-op
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!)
    {
        // Intentional no-op
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if let touch = touches.first as? UITouch
        {
            if touch.tapCount == 1
            {
                self.tapQueue.append(1)
            }
        }
    }
  
  //MARK: - HUD Helpers
    
    func adjustScoreBy(points: Int)
    {
        score += points
        let scoreLabel = childNodeWithName(kScoreHudName) as! SKLabelNode
        scoreLabel.text = String(format: "Score: %04u", score)
    }
    
    func adjustShipHealthBy(healthAdjustment: Float)
    {
        shipHealth = max(shipHealth + healthAdjustment, 0)
        let healthLabel = childNodeWithName(kHealthHudName) as! SKLabelNode
        healthLabel.text = String(format: "Health: %.1f%%", shipHealth * 100.0)
    }
  
  //MARK: - Physics Contact Helpers
    
    func didBeginContact(contact: SKPhysicsContact)
    {
        if contact as SKPhysicsContact? != nil
        {
            contactQueue.append(contact)
        }
    }
    
    func handleContact(contact: SKPhysicsContact)
    {
        if contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil
        {
            return
        }
        
        var nodeNames = [contact.bodyA.node!.name!, contact.bodyB.node!.name!]
        if (nodeNames as NSArray).containsObject(kShipName) && (nodeNames as NSArray).containsObject(kInvaderFiredBulletName)
        {
            runAction(SKAction.playSoundFileNamed("ShipHit.wav", waitForCompletion: false))
            adjustShipHealthBy(-0.334)
            
            if shipHealth <= 0.0
            {
                contact.bodyA.node!.removeFromParent()
                contact.bodyB.node!.removeFromParent()
            }
            else
            {
                let ship = childNodeWithName(kShipName)!
                ship.alpha = CGFloat(shipHealth)
                if contact.bodyA.node == ship
                {
                    contact.bodyB.node!.removeFromParent()
                }
                else
                {
                    contact.bodyA.node!.removeFromParent()
                }
            }
        }
        else if (nodeNames as NSArray).containsObject(kInvaderName) && (nodeNames as NSArray).containsObject(kShipFiredBulletName)
        {
            runAction(SKAction.playSoundFileNamed("InvaderHit.wav", waitForCompletion: false))
            contact.bodyA.node!.removeFromParent()
            contact.bodyB.node!.removeFromParent()
            adjustScoreBy(100)
        }
    }
  
  //MARK: - Game End Helpers
  
    func isGameOver() -> Bool
    {
        let invader = childNodeWithName(kInvaderName)
        var invaderTooLow = false
        enumerateChildNodesWithName(kInvaderName) {
            node, stop in
            if Float(CGRectGetMinY(node.frame)) <= self.kMinInvaderBottomHeight
            {
                invaderTooLow = true
                stop.memory = true
            }
        }
        let ship = childNodeWithName(kShipName)
        return invader == nil || invaderTooLow || ship == nil
    }
    
    func endGame()
    {
        if !gameEnding
        {
            gameEnding = true
            motionManager.stopAccelerometerUpdates()
            let gameOverScene: GameOverScene = GameOverScene(size: size)
            view!.presentScene(gameOverScene, transition: SKTransition.doorsOpenHorizontalWithDuration(1.0))
        }
    }
    
    
    
    
    
    
    
}













