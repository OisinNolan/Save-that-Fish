//
//  GameScene.swift
//  Swim Fish Swim!
//
//  Created by Nuala O' Dea on 19/08/2015.
//  Copyright (c) 2015 oisinnolan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var viewController : GameViewController!
    
    // SKSpriteNode Global variables
    var charImage = String()
    var char = SKSpriteNode()
    var sky = SKSpriteNode()
    var sea = SKSpriteNode()
    var sun = SKSpriteNode()
    var ground = SKSpriteNode()
    var mountains = SKSpriteNode()
    var drop = SKSpriteNode()
    var megaDrop = SKSpriteNode()
    var coin = SKSpriteNode()
    var seagull = SKSpriteNode()
    var shark = SKSpriteNode()
    var ship = SKSpriteNode()
    var chest = SKSpriteNode()
    var chestReward = SKSpriteNode()
    var title = SKSpriteNode()
    var howToPlayButton = SKSpriteNode()
    var shopButton = SKSpriteNode()
    var leaderboardButton = SKSpriteNode()
    
    // category bitmasks
    let charCategory: UInt32 = 0x1 << 0
    let dropCategory: UInt32 = 0x1 << 1
    let seagullCategory: UInt32 = 0x1 << 2
    let sharkCategory: UInt32 = 0x1 << 3
    let shipCategory: UInt32 = 0x1 << 4
    let coinCategory: UInt32 = 0x1 << 5
    
    // variables to make the sea go down
    var seaRate = CGFloat()
    var seaTop = CGFloat()
    var seaTimer = NSTimer()
    var seaUp = CGFloat()
    
    var groundTop = CGFloat()
    
    // character position bools
    var isLeft = false
    var isRight = true
    
    // drop characteristics
    var dropSpeed = 3.2
    var dropTimer = NSTimer()
    var megaDropTimer = NSTimer()
    
    // coin characteristics
    var coinTimer = NSTimer()
    var score = Int()
    var coinAmount = Int()
    
    // set up game variables
    var gameStarted = Bool()
    
    // seagull vars
    var fishCaught = false
    
    // chest vars
    var chestOpen = false
    var chestTimer = NSTimer()
    
    //timer vars
    var scoreTimer = NSTimer()
    
    var scoreScreenCenter = CGPoint()
    
    var highscore = Int()
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        initialize()
    }
    
    func initialize() {
        
        self.removeAllChildren()
        
        // set charImage
        setTheChar()
        
        // set sky
        sky = SKSpriteNode(imageNamed: "sky")
        sky.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        sky.size = CGSize(width: frame.size.width, height: frame.size.height)
        sky.zPosition = 1
        sky.name = "sky"
        
        // set sun
        sun = SKSpriteNode(imageNamed: "sun")
        sun.position = CGPoint(x: frame.size.width / 2.7, y: frame.size.height / 1.1)
        sun.size = CGSize(width: 75, height: 75)
        sun.zPosition = 2
        sun.name = "sun"
        
        // set sea
        sea = SKSpriteNode(imageNamed: "sea")
        sea.position = CGPointMake(self.size.width / 2, self.size.height / 8)
        sea.size = CGSize(width: frame.size.width / 1.75 , height: frame.size.height)
        sea.zPosition = 3
        sea.name = "sea"
        
        // set ground
        ground = SKSpriteNode(imageNamed: "ground")
        ground.position = CGPointMake(frame.size.width / 2, frame.size.height / 50)
        ground.size = CGSize(width: frame.size.width / 1.75, height: 40)
        ground.zPosition = 5
        ground.name = "ground"
        
        // set mountains
        mountains = SKSpriteNode(imageNamed: "mountains")
        mountains.position = CGPointMake(self.size.width / 2, (self.size.height / 2) - 20)
        mountains.size = CGSize(width: frame.size.width / 1.75, height: frame.size.height)
        mountains.zPosition = 2
        mountains.name = "mountains"
        
        // setting values for sea vars
        seaRate = 2
        seaTop = sea.position.y + (sea.size.height / 2) - 20
        seaUp = 20
        
        // set title
        title = SKSpriteNode(imageNamed: "titleImage")
        title.position.x = self.size.width / 2
        title.position.y = seaTop + 90
        title.size = CGSize(width: 300, height: 300)
        title.zPosition = 20
        title.name = "title"
        
        // set leaderboard button
        leaderboardButton = SKSpriteNode(imageNamed: "leaderboardImage")
        leaderboardButton.position.x = self.size.width / 2
        leaderboardButton.position.y = char.position.y - 100
        leaderboardButton.size = CGSize(width: 60, height: 60)
        leaderboardButton.zPosition = 20
        leaderboardButton.name = "leaderboardButton"
        
        // set how to play button
        howToPlayButton = SKSpriteNode(imageNamed: "howToPlayImage")
        howToPlayButton.position.x = char.position.x - 100
        howToPlayButton.position.y = leaderboardButton.position.y + 30
        howToPlayButton.size = CGSize(width: 60, height: 60)
        howToPlayButton.zPosition = 20
        howToPlayButton.name = "howToPlayButton"
        
        // set shop button
        shopButton = SKSpriteNode(imageNamed: "shopImage")
        shopButton.position.x = char.position.x + 100
        shopButton.position.y = leaderboardButton.position.y + 30
        shopButton.size = CGSize(width: 60, height: 60)
        shopButton.zPosition = 20
        shopButton.name = "shopButton"
        
        // ground values
        groundTop = ground.position.y + (ground.size.height / 2) + 5
        
        // game values
        gameStarted = false
        
        // set values for UI elements
        viewController.dangerImage.hidden = true
        viewController.chestRewardLabel.hidden = true
        
        // set score
        score = 0
        
        checkCoins()
        
        // add children
        self.addChild(sky)
        self.addChild(sun)
        self.addChild(sea)
        self.addChild(char)
        self.addChild(ground)
        self.addChild(mountains)
        self.addChild(title)
        self.addChild(leaderboardButton)
        self.addChild(howToPlayButton)
        self.addChild(shopButton)
        
    }
    
    func startGame() {
        
        gameStarted = true
        
        title.runAction(SKAction.fadeOutWithDuration(1.0))
        howToPlayButton.runAction(SKAction.fadeOutWithDuration(1.0))
        leaderboardButton.runAction(SKAction.fadeOutWithDuration(1.0))
        shopButton.runAction(SKAction.fadeOutWithDuration(1.0))
        viewController.fadeHighscore()
        delay(1.0) {
            self.title.removeFromParent()
            self.howToPlayButton.removeFromParent()
            self.leaderboardButton.removeFromParent()
            self.shopButton.removeFromParent()
            self.viewController.highscoreLabel.hidden = true
            self.viewController.highscoreLabel.alpha = 1.0
        }
        delay(1.6) {
            self.viewController.scoreLabel.hidden = false
        }
        
        dropTimer = NSTimer.scheduledTimerWithTimeInterval(0.225, target: self, selector: Selector("drops"), userInfo: nil, repeats: true)
        
        megaDropTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("megaDrops"), userInfo: nil, repeats: true)
        
        coinTimer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("coins"), userInfo: nil, repeats: true)
        
        seaTimer = NSTimer.scheduledTimerWithTimeInterval(0.29, target: self, selector: Selector("seaDown"), userInfo: nil, repeats: true)
        
        chestTimer = NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: Selector("chestTest"), userInfo: nil, repeats: true)
        
        scoreTimer = NSTimer.scheduledTimerWithTimeInterval(1.3, target: self, selector: Selector("addScore"), userInfo: nil, repeats: true)
    }
    
    func setTheChar() {
        
        var theChar = NSUserDefaults.standardUserDefaults().integerForKey("selectedChar")
        
        switch theChar {
            
        case 1:
            
            charImage = "fish"
            char = SKSpriteNode(imageNamed: charImage + "Right")
            char.position = CGPointMake(frame.size.width / 2, frame.size.height / 2)
            char.size = CGSize(width: 50, height: 38)
            char.zPosition = 7
            
            char.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: char.size.width, height: char.size.height))
            char.physicsBody?.affectedByGravity = false
            char.physicsBody?.dynamic = false
            char.physicsBody?.usesPreciseCollisionDetection = true
            char.physicsBody?.categoryBitMask = charCategory
            char.physicsBody?.collisionBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.physicsBody?.contactTestBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.name = "char"
            
            break
        case 2:
            
            charImage = "jellyfish"
            char = SKSpriteNode(imageNamed: charImage + "Right")
            char.position = CGPointMake(frame.size.width / 2, frame.size.height / 2)
            char.size = CGSize(width: 35, height: 55)
            char.zPosition = 7
            
            char.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: char.size.width, height: char.size.height))
            char.physicsBody?.affectedByGravity = false
            char.physicsBody?.dynamic = false
            char.physicsBody?.usesPreciseCollisionDetection = true
            char.physicsBody?.categoryBitMask = charCategory
            char.physicsBody?.collisionBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.physicsBody?.contactTestBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.name = "char"
            
            break
        case 3:
            
            charImage = "bigfish"
            char = SKSpriteNode(imageNamed: charImage + "Right")
            char.position = CGPointMake(frame.size.width / 2, frame.size.height / 2)
            char.size = CGSize(width: 100, height: 50)
            char.zPosition = 7
            
            char.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: char.size.width, height: char.size.height))
            char.physicsBody?.affectedByGravity = false
            char.physicsBody?.dynamic = false
            char.physicsBody?.usesPreciseCollisionDetection = true
            char.physicsBody?.categoryBitMask = charCategory
            char.physicsBody?.collisionBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.physicsBody?.contactTestBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.name = "char"
            
            break
        case 4:
            
            charImage = "turtle"
            char = SKSpriteNode(imageNamed: charImage + "Right")
            char.position = CGPointMake(frame.size.width / 2, frame.size.height / 2)
            char.size = CGSize(width: 60, height: 48)
            char.zPosition = 7
            
            char.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: char.size.width, height: char.size.height))
            char.physicsBody?.affectedByGravity = false
            char.physicsBody?.dynamic = false
            char.physicsBody?.usesPreciseCollisionDetection = true
            char.physicsBody?.categoryBitMask = charCategory
            char.physicsBody?.collisionBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.physicsBody?.contactTestBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.name = "char"
            
            break
        case 5:
            
            charImage = "dolphin"
            char = SKSpriteNode(imageNamed: charImage + "Right")
            char.position = CGPointMake(frame.size.width / 2, frame.size.height / 2)
            char.size = CGSize(width: 100, height: 60)
            char.zPosition = 7
            
            char.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: char.size.width, height: char.size.height))
            char.physicsBody?.affectedByGravity = false
            char.physicsBody?.dynamic = false
            char.physicsBody?.usesPreciseCollisionDetection = true
            char.physicsBody?.categoryBitMask = charCategory
            char.physicsBody?.collisionBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.physicsBody?.contactTestBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.name = "char"
            
            break
        case 6:
            
            charImage = "seahorse"
            char = SKSpriteNode(imageNamed: charImage + "Right")
            char.position = CGPointMake(frame.size.width / 2, frame.size.height / 2)
            char.size = CGSize(width: 40, height: 95)
            char.zPosition = 7
            
            char.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: char.size.width, height: char.size.height))
            char.physicsBody?.affectedByGravity = false
            char.physicsBody?.dynamic = false
            char.physicsBody?.usesPreciseCollisionDetection = true
            char.physicsBody?.categoryBitMask = charCategory
            char.physicsBody?.collisionBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.physicsBody?.contactTestBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.name = "char"
            
            break
        default:
            
            charImage = "fish"
            char = SKSpriteNode(imageNamed: charImage + "Right")
            char.position = CGPointMake(frame.size.width / 2, frame.size.height / 2)
            char.size = CGSize(width: 50, height: 38)
            char.zPosition = 7
            
            char.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: char.size.width, height: char.size.height))
            char.physicsBody?.affectedByGravity = false
            char.physicsBody?.dynamic = false
            char.physicsBody?.usesPreciseCollisionDetection = true
            char.physicsBody?.categoryBitMask = charCategory
            char.physicsBody?.collisionBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.physicsBody?.contactTestBitMask = dropCategory | seagullCategory | sharkCategory | shipCategory | coinCategory
            char.name = "char"
            
            break
            
        }
        
    }
    
    func addScore() {
        
        score++
        viewController.scoreLabel.text = String(score)
        
        highscore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
        if score > highscore {
            
            highscore = score
            viewController.highscoreLabel.text = "Highscore " + String(highscore)
            NSUserDefaults.standardUserDefaults().setInteger(highscore, forKey: "highscore")
            NSUserDefaults.standardUserDefaults().synchronize()
            viewController.saveHighscore(highscore)
            
        }
        
    }
    
    func shipAttack() {
        
        ship = SKSpriteNode(imageNamed: "ship")
        ship.position = CGPoint(x: frame.size.width * 2 - 100, y: seaTop + 80)
        ship.size = CGSize(width: 1100, height: 400)
        ship.zPosition = 2
        
        var shipSize = CGSize(width: ship.size.width - 80, height: ship.size.height)
        
        ship.physicsBody = SKPhysicsBody(rectangleOfSize: shipSize)
        ship.physicsBody?.affectedByGravity = false
        ship.physicsBody?.dynamic = true
        ship.physicsBody?.usesPreciseCollisionDetection = true
        ship.physicsBody?.categoryBitMask = shipCategory
        ship.physicsBody?.collisionBitMask = charCategory
        ship.physicsBody?.contactTestBitMask = charCategory
        ship.name = "ship"
        self.addChild(ship)
        
        ship.runAction(SKAction.moveToX(-(frame.size.width) - 50, duration: 16))
        
    }
    
    func sharkAttack() {
        
        shark = SKSpriteNode(imageNamed: "shark")
        shark.position = CGPoint(x: -(frame.size.width), y: ground.position.y + 150)
        shark.size = CGSize(width: 246, height: 135)
        shark.zPosition = 7
        
        shark.physicsBody = SKPhysicsBody(rectangleOfSize: shark.size)
        shark.physicsBody?.affectedByGravity = false
        shark.physicsBody?.dynamic = true
        shark.physicsBody?.usesPreciseCollisionDetection = true
        shark.physicsBody?.categoryBitMask = sharkCategory
        shark.physicsBody?.collisionBitMask = charCategory
        shark.physicsBody?.contactTestBitMask = charCategory
        shark.name = "shark"
        self.addChild(shark)
        
        shark.runAction(SKAction.moveToX(frame.size.width + 50, duration: 10))
    }
    
    func seagullAttack() {
        
        seagull = SKSpriteNode(imageNamed:  "seagull1")
        seagull.position = CGPoint(x: -(frame.size.width), y: frame.size.height * 2)
        seagull.size = CGSize(width: 82, height: 94)
        seagull.zPosition = 7
        
        seagull.physicsBody = SKPhysicsBody(circleOfRadius: seagull.size.width / 2)
        seagull.physicsBody?.affectedByGravity = false
        seagull.physicsBody?.dynamic = true
        seagull.physicsBody?.usesPreciseCollisionDetection = true
        seagull.physicsBody?.categoryBitMask = seagullCategory
        seagull.physicsBody?.collisionBitMask = charCategory
        seagull.physicsBody?.contactTestBitMask = charCategory
        seagull.name = "seagull"
        self.addChild(seagull)
        
        seagull.runAction(SKAction.moveTo(char.position, duration: 5.5))
        delay(5.1) {
            if !self.fishCaught {
                self.seagull.texture = SKTexture(imageNamed: "seagull2")
                self.seagull.size = CGSize(width: 79, height: 115)
                self.seagull.position.x += 20
                self.seagull.runAction(SKAction.moveTo(CGPoint(x: self.frame.size.width + 30, y: self.frame.size.height), duration: 2.0))
            }
        }
        
    }
    
    func shipCatch() {
        ship.zRotation = 0
        ship.texture = SKTexture(imageNamed: "ship2" + charImage)
        delay(4.0) {
            self.gameOver()
        }
        
    }
    
    func sharkCatch() {
        
        shark.texture = SKTexture(imageNamed: "sharkbite" + charImage)
        shark.zRotation = 0
        delay(0.1) {
            self.shark.texture = SKTexture(imageNamed: "shark" + self.charImage)
        }
        delay(4.0) {
            self.gameOver()
        }
    }
    
    func seagullCatch() {
        
        fishCaught = true
        seagull.texture = SKTexture(imageNamed: "seagull" + charImage)
        seagull.size = CGSize(width: 79, height: 115)
        seagull.position.x += 20
        seagull.runAction(SKAction.moveTo(CGPoint(x: frame.size.width + 30, y: frame.size.height), duration: 2.0))
        delay(4.0) {
            
            self.gameOver()
            
        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            if !gameStarted {
                
                let location = touch.locationInNode(self)
                let touchedNode = nodeAtPoint(location)
                
                if let name = touchedNode.name {
                    if name == "howToPlayButton" {
                        
                        self.viewController.goToHowToPlay()
                        
                    }
                    if name == "shopButton" {
                        
                        self.viewController.goToShop()
                        
                    }
                    if name == "leaderboardButton" {
                        
                        self.viewController.showLeader()
                        
                    }
                    else {
                        startGame()
                    }
                }
                
                
            }
            
            if gameStarted {
                
                let location = touch.locationInNode(self)
                let touchedNode = nodeAtPoint(location)
                
                // setting up SKActions
                var moveAction = SKAction.moveTo(location, duration: 0.4)
                moveAction.timingMode = SKActionTimingMode.EaseOut
                
                var rotateUpLeftAction = SKAction.rotateByAngle(-0.5, duration: 0.2)
                rotateUpLeftAction.timingMode = SKActionTimingMode.EaseInEaseOut
                
                var rotateUpRightAction = SKAction.rotateByAngle(+0.5, duration: 0.2)
                rotateUpLeftAction.timingMode = SKActionTimingMode.EaseInEaseOut
                
                var rotateDownRightAction = SKAction.rotateByAngle(-0.5, duration: 0.2)
                rotateUpLeftAction.timingMode = SKActionTimingMode.EaseInEaseOut
                
                var rotateDownLeftAction = SKAction.rotateByAngle(+0.5, duration: 0.2)
                rotateUpLeftAction.timingMode = SKActionTimingMode.EaseInEaseOut
                
                if let name = touchedNode.name {
                    if name == "sea" {
                        char.runAction(moveAction)
                        if char.position.x < location.x {
                            charTurnRight()
                        }
                        if char.position.x > location.x {
                            charTurnLeft()
                        }
                        if char.position.y < location.y && isLeft {
                            char.runAction(rotateUpLeftAction)
                            delay(0.2) {
                                self.char.runAction(rotateDownLeftAction)
                            }
                        }
                        if char.position.y > location.y && isLeft {
                            char.runAction(rotateDownLeftAction)
                            delay(0.2) {
                                self.char.runAction(rotateUpLeftAction)
                            }
                        }
                        if char.position.y < location.y && isRight {
                            char.runAction(rotateUpRightAction)
                            delay(0.2) {
                                self.char.runAction(rotateDownRightAction)
                            }
                        }
                        if char.position.y > location.y && isRight {
                            char.runAction(rotateDownRightAction)
                            delay(0.2) {
                                self.char.runAction(rotateUpRightAction)
                            }
                        }
                    }
                    
                    if name == "chest" && !chestOpen {
                        
                        openChest()
                        
                    }
                }
                
            }
            
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA != nil && contact.bodyB != nil) {
            if contact.bodyA.node != nil && contact.bodyB.node != nil {
                
                let firstBody = contact.bodyA.node as! SKSpriteNode
                let secondBody = contact.bodyB.node as! SKSpriteNode
                
                if firstBody.name != nil && secondBody.name != nil {
                    
                    // char and drop contact
                    
                    if firstBody.name == "char" && secondBody.name == "drop" {
                        
                        dropCollision()
                        secondBody.removeFromParent()
                        contact.bodyA.node!.zRotation = 0
                        
                    }
                    
                    if firstBody.name == "drop" && secondBody.name == "char" {
                        
                        dropCollision()
                        firstBody.removeFromParent()
                        contact.bodyB.node!.zRotation = 0
                        
                    }
                    
                    if firstBody.name == "char" && secondBody.name == "megaDrop" {
                        
                        megaDropCollision()
                        secondBody.removeFromParent()
                        contact.bodyA.node!.zRotation = 0
                        
                    }
                    
                    if firstBody.name == "megaDrop" && secondBody.name == "char" {
                        
                        megaDropCollision()
                        firstBody.removeFromParent()
                        contact.bodyB.node!.zRotation = 0
                        
                    }
                    
                    // seagull char contact
                    
                    if firstBody.name == "char" && secondBody.name == "seagull" {
                        
                        firstBody.removeFromParent()
                        seagullCatch()
                        
                    }
                    
                    if firstBody.name == "seagull" && secondBody.name == "char" {
                        
                        secondBody.removeFromParent()
                        seagullCatch()
                        
                    }
                    
                    if firstBody.name == "char" && secondBody.name == "shark" {
                        
                        firstBody.removeFromParent()
                        sharkCatch()
                        
                    }
                    
                    if firstBody.name == "shark" && secondBody.name == "char" {
                        
                        secondBody.removeFromParent()
                        sharkCatch()
                        
                    }
                    
                    if firstBody.name == "char" && secondBody.name == "ship" {
                        
                        firstBody.removeFromParent()
                        shipCatch()
                        
                    }
                    
                    if firstBody.name == "ship" && secondBody.name == "char" {
                        
                        secondBody.removeFromParent()
                        shipCatch()
                        
                    }
                    
                    if firstBody.name == "char" && secondBody.name == "coin" {
                        
                        secondBody.removeFromParent()
                        coinCollision()
                        
                    }
                    
                    if firstBody.name == "coin" && secondBody.name == "char" {
                        
                        firstBody.removeFromParent()
                        coinCollision()
                        
                    }
                }
            }
        }
    }
    
    func dropCollision() {
        
        if sea.position.y < 230 {
            
            seaUp += 0.02
            
            sea.position.y += seaUp
            seaTop += seaUp
            
        }
    }
    
    func megaDropCollision() {
        
        var toTop = seaTop - sea.position.y
        sea.position.y = 230
        seaTop = toTop + 230
        
    }
    
    func coinCollision() {
        
        coinAmount += 1
        NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount")
        NSUserDefaults.standardUserDefaults().synchronize()
        viewController.coinAmountLabel.text = String(coinAmount)
        viewController.saveCoins(coinAmount)
        
    }
    
    func checkCoins() {
        
        coinAmount = NSUserDefaults.standardUserDefaults().integerForKey("coinAmount")
        NSUserDefaults.standardUserDefaults().synchronize()
        viewController.coinAmountLabel.text = String(coinAmount)
        viewController.saveCoins(coinAmount)
        
    }
    
    func charTurnRight() {
        isRight = true
        isLeft = false
        char.texture = SKTexture(imageNamed: charImage + "Right")
        delay(0.1) {
            self.char.texture = SKTexture(imageNamed: self.charImage + "RightSwim")
        }
        delay(0.2) {
            self.char.texture = SKTexture(imageNamed: self.charImage + "Right")
        }
        delay(0.3) {
            self.char.texture = SKTexture(imageNamed: self.charImage + "RightSwim")
        }
        delay(0.4) {
            self.char.texture = SKTexture(imageNamed: self.charImage + "Right")
        }
    }
    
    func charTurnLeft() {
        isLeft = true
        isRight = false
        char.texture = SKTexture(imageNamed: charImage + "Left")
        delay(0.1) {
            self.char.texture = SKTexture(imageNamed: self.charImage + "LeftSwim")
        }
        delay(0.2) {
            self.char.texture = SKTexture(imageNamed: self.charImage + "Left")
        }
        delay(0.3) {
            self.char.texture = SKTexture(imageNamed: self.charImage + "LeftSwim")
        }
        delay(0.4) {
            self.char.texture = SKTexture(imageNamed: self.charImage + "Left")
        }
    }
    
    func drops() {
        
        var rand = arc4random_uniform(2) + 1
        
        if rand == 1 {
            
            drop = SKSpriteNode(imageNamed: "drop")
            drop.size = CGSize(width: 20, height: 35)
            drop.position.y = frame.size.height + 10
            drop.zPosition = 4
            drop.alpha = 1.0
            var xPos = arc4random_uniform(UInt32(frame.size.width))
            drop.position.x = CGFloat(xPos)
            drop.runAction(SKAction.moveToY(-(frame.size.height - 10), duration: dropSpeed))
            drop.physicsBody = SKPhysicsBody(circleOfRadius: 8)
            drop.physicsBody?.affectedByGravity = false
            drop.physicsBody?.dynamic = true
            drop.physicsBody?.usesPreciseCollisionDetection = true
            drop.physicsBody?.categoryBitMask = dropCategory
            drop.physicsBody?.collisionBitMask = charCategory
            drop.physicsBody?.contactTestBitMask = charCategory
            drop.name = "drop"
            
            self.addChild(drop)
            
        }
    }
    
    func megaDrops() {
        
        var rand = arc4random_uniform(3) + 1
        
        if rand == 1 {
            
            megaDrop = SKSpriteNode(imageNamed: "megadrop")
            megaDrop.size = CGSize(width: 25, height: 48)
            megaDrop.position.y = frame.size.height + 10
            megaDrop.zPosition = 4
            megaDrop.alpha = 1.0
            var xPos = arc4random_uniform(UInt32(frame.size.width))
            megaDrop.position.x = CGFloat(xPos)
            megaDrop.runAction(SKAction.moveToY(-(frame.size.height - 10), duration: dropSpeed))
            megaDrop.physicsBody = SKPhysicsBody(circleOfRadius: 11)
            megaDrop.physicsBody?.affectedByGravity = false
            megaDrop.physicsBody?.dynamic = true
            megaDrop.physicsBody?.usesPreciseCollisionDetection = true
            megaDrop.physicsBody?.categoryBitMask = dropCategory
            megaDrop.physicsBody?.collisionBitMask = charCategory
            megaDrop.physicsBody?.contactTestBitMask = charCategory
            megaDrop.name = "megaDrop"
            
            self.addChild(megaDrop)
            
        }
    }
    
    func coins() {
        
        coin = SKSpriteNode(imageNamed: "coin")
        coin.size = CGSize(width: 50, height: 50)
        coin.position.y = frame.size.height + 10
        coin.zPosition = 4
        coin.alpha = 1.0
        var xPos = arc4random_uniform(UInt32(frame.size.width))
        coin.position.x = CGFloat(xPos)
        coin.runAction(SKAction.moveToY(-(frame.size.height - 10), duration: dropSpeed))
        coin.physicsBody = SKPhysicsBody(circleOfRadius: 22)
        coin.physicsBody?.affectedByGravity = false
        coin.physicsBody?.dynamic = true
        coin.physicsBody?.usesPreciseCollisionDetection = true
        coin.physicsBody?.categoryBitMask = dropCategory
        coin.physicsBody?.collisionBitMask = coinCategory
        coin.physicsBody?.contactTestBitMask = coinCategory
        coin.name = "coin"
        
        self.addChild(coin)
        
    }
    
    var chestCount = 0
    
    func chestTest() {
        
        NSLog("chestTest")
        
        chestCount++
        
        if chestCount > 5 {
            
            var rand = arc4random_uniform(3) + 1
            
            if rand == 1 {
                
                chestSpawn()
                
            }
            
        }
        
    }
    
    func chestSpawn() {
        
        chest = SKSpriteNode(imageNamed: "chestCount3")
        chest.position.y = ground.position.y + 32
        var xPos = arc4random_uniform(UInt32(frame.size.width))
        chest.position.x = CGFloat(xPos)
        chest.zPosition = 6
        chest.name = "chest"
        
        self.addChild(chest)
        
        chest.size = CGSize(width: 100 * 1.2, height: 133 * 1.2)
        chest.runAction(SKAction.scaleBy(0.75, duration: 0.79))
        
        delay(0.8) {
            if !self.chestOpen {
                self.chest.texture = SKTexture(imageNamed: "chestCount2")
                self.chest.size = CGSize(width: 100 * 1.2, height: 133 * 1.2)
                self.chest.runAction(SKAction.scaleBy(0.75, duration: 0.79))
            }
        }
        delay(1.6) {
            if !self.chestOpen {
                self.chest.texture = SKTexture(imageNamed: "chestCount1")
                self.chest.size = CGSize(width: 100 * 1.2, height: 133 * 1.2)
                self.chest.runAction(SKAction.scaleBy(0.75, duration: 0.79))
                self.chest.runAction(SKAction.fadeOutWithDuration(0.79))
            }
        }
        delay(2.4) {
            if !self.chestOpen {
                self.chest.removeFromParent()
            }
        }
        
    }
    
    func openChest() {
        
        chestOpen = true
        
        chest.removeAllActions()
        chest.size = CGSize(width: 100, height: 100)
        chest.texture = SKTexture(imageNamed: "chestOpen")
        
        delay(1.5) {
            self.chest.removeFromParent()
            self.chestOpen = false
        }
        
        chestReward = SKSpriteNode(imageNamed: "chestReward")
        chestReward.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        chestReward.size = CGSize(width: 170, height: 170)
        chestReward.zPosition = 10
        chestReward.name = "chestReward"
        
        var randCoin = arc4random_uniform(50) + 1
        var coinReward = Int()
        
        if randCoin < 41 && randCoin > 1 {
            
            coinReward = Int(randCoin) / 2
            coinAmount = coinAmount + coinReward
            
            NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount")
            NSUserDefaults.standardUserDefaults().synchronize()
            viewController.coinAmountLabel.text = String(coinAmount)
            
        }
        if randCoin > 40 && randCoin < 50 {
            
            coinReward = Int(randCoin)
            coinAmount = coinAmount + coinReward
            
            NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount")
            NSUserDefaults.standardUserDefaults().synchronize()
            viewController.coinAmountLabel.text = String(coinAmount)
            
        }
        if randCoin == 50 {
            
            NSLog("3")
            
            coinReward = 100
            coinAmount = coinAmount + coinReward
            
            NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount")
            NSUserDefaults.standardUserDefaults().synchronize()
            viewController.coinAmountLabel.text = String(coinAmount)
            
        }
        if randCoin == 1 {
            
            coinReward = 1
            coinAmount = coinAmount + coinReward
            
            NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount")
            NSUserDefaults.standardUserDefaults().synchronize()
            viewController.coinAmountLabel.text = String(coinAmount)
            
        }
        
        viewController.chestRewardLabel.hidden = false
        self.addChild(chestReward)
        viewController.chestRewardLabel.alpha = 1.0
        viewController.chestRewardLabel.text = String(coinReward)
        UILabel.animateWithDuration(2.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.viewController.chestRewardLabel.alpha = 0.0
            }, completion: nil)
        delay(0.4) {
            self.chestReward.runAction(SKAction.fadeOutWithDuration(2.0))
            self.delay(2.0) {
                self.chestReward.removeFromParent()
            }
        }
        
    }
    
    var distanceFromDanger = 1
    
    // SEA DOWN
    
    func seaDown() {
        
        seaRate += 0.02
        
        sea.position.y -= seaRate
        seaTop -= seaRate
        
        if seaTop < 0 {
            seaTimer.invalidate()
            gameOver()
        }
        
        // DANGER
        
        distanceFromDanger++
        
        if distanceFromDanger > 50 {
            
            if sea.position.y > -29 {
                
                var rand = arc4random_uniform(50) + 1
                
                if rand == 1 {
                    
                    danger()
                    distanceFromDanger = 0
                    
                }
                
            }
            
        }
        
    }
    
    func danger() {
        
        var rand = arc4random_uniform(3) + 1
        
        viewController.dangerImage.hidden = false
        delay(3.0) {
            
            
            self.viewController.dangerImage.hidden = true
            
            if rand == 1 {
                self.seagullAttack()
            }
            if rand == 2 {
                self.sharkAttack()
            }
            if rand == 3 {
                self.shipAttack()
            }
            
        }
        
    }
    
    var adCounter = 1
    
    func gameOver() {
        
        adCounter++
        if adCounter % 2 == 0 {
            
            if (viewController.interstitial.isReady) {
                
                viewController.interstitial.presentFromRootViewController(viewController)
                viewController.interstitial = viewController.createAndLoadAd()
                
            }
            
        }
        
        sea.removeFromParent()
        viewController.scoreLabel.hidden = true
        viewController.highscoreLabel.hidden = false
        restartGame()
        
    }
    
    func restartGame() {
        seaTimer.invalidate()
        dropTimer.invalidate()
        megaDropTimer.invalidate()
        coinTimer.invalidate()
        chestTimer.invalidate()
        scoreTimer.invalidate()
        fishCaught = false
        distanceFromDanger = 0
        seaRate = 0
        score = 0
        chestCount = 0
        initialize()
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        if char.position.y > seaTop && char.position.y > groundTop {
            
            char.position.y -= seaRate
            
        }
        
        if ship.position.y != seaTop + 80 {
            
            ship.position.y = seaTop + 80
            
        }
        
    }
    
    func delay(delayInSeconds:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delayInSeconds * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
