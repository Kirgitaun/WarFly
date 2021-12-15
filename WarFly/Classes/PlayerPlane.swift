//
//  PlayerPlane.swift
//  WarFly
//
//  Created by Alex Alexandro on 09.03.2021.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    var leftTextureArrayAnimation = [SKTexture]()
    var rightTextureArrayAnimation = [SKTexture]()
    var forwardTextureArrayAnimation = [SKTexture]()
    var moveDirection: TurnDirection = .none
    var stillTurning = false
    let animationSpriteStrides = [(13, 1, -1), (13, 26, 1), (13, 13, 1)]
    
    static func populate(at point: CGPoint) -> PlayerPlane {
        
        let playerPlaneTexture = Assets.shared.playerPlaneAtlas.textureNamed("airplane_3ver2_13") //SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 40
        
        let offsetX = playerPlane.frame.size.width * playerPlane.anchorPoint.x
        let offsetY = playerPlane.frame.size.height * playerPlane.anchorPoint.y
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 10 - offsetX, y: 76 - offsetY))
        path.addLine(to: CGPoint(x: 66 - offsetX, y: 85 - offsetY))
        path.addLine(to: CGPoint(x: 71 - offsetX, y: 99 - offsetY))
        path.addLine(to: CGPoint(x: 78 - offsetX, y: 99 - offsetY))
        path.addLine(to: CGPoint(x: 83 - offsetX, y: 86 - offsetY))
        path.addLine(to: CGPoint(x: 98 - offsetX, y: 81 - offsetY))
        path.addLine(to: CGPoint(x: 110 - offsetX, y: 80 - offsetY))
        path.addLine(to: CGPoint(x: 138 - offsetX, y: 75 - offsetY))
        path.addLine(to: CGPoint(x: 142 - offsetX, y: 72 - offsetY))
        path.addLine(to: CGPoint(x: 141 - offsetX, y: 67 - offsetY))
        path.addLine(to: CGPoint(x: 130 - offsetX, y: 63 - offsetY))
        path.addLine(to: CGPoint(x: 103 - offsetX, y: 60 - offsetY))
        path.addLine(to: CGPoint(x: 89 - offsetX, y: 58 - offsetY))
        path.addLine(to: CGPoint(x: 85 - offsetX, y: 58 - offsetY))
        path.addLine(to: CGPoint(x: 83 - offsetX, y: 51 - offsetY))
        path.addLine(to: CGPoint(x: 81 - offsetX, y: 38 - offsetY))
        path.addLine(to: CGPoint(x: 80 - offsetX, y: 31 - offsetY))
        path.addLine(to: CGPoint(x: 79 - offsetX, y: 26 - offsetY))
        path.addLine(to: CGPoint(x: 79 - offsetX, y: 24 - offsetY))
        path.addLine(to: CGPoint(x: 78 - offsetX, y: 23 - offsetY))
        path.addLine(to: CGPoint(x: 85 - offsetX, y: 21 - offsetY))
        path.addLine(to: CGPoint(x: 92 - offsetX, y: 19 - offsetY))
        path.addLine(to: CGPoint(x: 95 - offsetX, y: 14 - offsetY))
        path.addLine(to: CGPoint(x: 94 - offsetX, y: 10 - offsetY))
        path.addLine(to: CGPoint(x: 90 - offsetX, y: 8 - offsetY))
        path.addLine(to: CGPoint(x: 83 - offsetX, y: 8 - offsetY))
        path.addLine(to: CGPoint(x: 78 - offsetX, y: 8 - offsetY))
        path.addLine(to: CGPoint(x: 77 - offsetX, y: 6 - offsetY))
        path.addLine(to: CGPoint(x: 76 - offsetX, y: 5 - offsetY))
        path.addLine(to: CGPoint(x: 72 - offsetX, y: 7 - offsetY))
        path.addLine(to: CGPoint(x: 69 - offsetX, y: 8 - offsetY))
        path.addLine(to: CGPoint(x: 63 - offsetX, y: 8 - offsetY))
        path.addLine(to: CGPoint(x: 59 - offsetX, y: 8 - offsetY))
        path.addLine(to: CGPoint(x: 55 - offsetX, y: 9 - offsetY))
        path.addLine(to: CGPoint(x: 54 - offsetX, y: 11 - offsetY))
        path.addLine(to: CGPoint(x: 55 - offsetX, y: 15 - offsetY))
        path.addLine(to: CGPoint(x: 57 - offsetX, y: 17 - offsetY))
        path.addLine(to: CGPoint(x: 57 - offsetX, y: 20 - offsetY))
        path.addLine(to: CGPoint(x: 63 - offsetX, y: 21 - offsetY))
        path.addLine(to: CGPoint(x: 67 - offsetX, y: 22 - offsetY))
        path.addLine(to: CGPoint(x: 71 - offsetX, y: 23 - offsetY))
        path.addLine(to: CGPoint(x: 71 - offsetX, y: 24 - offsetY))
        path.addLine(to: CGPoint(x: 66 - offsetX, y: 56 - offsetY))
        path.addLine(to: CGPoint(x: 9 - offsetX, y: 65 - offsetY))
        path.addLine(to: CGPoint(x: 8 - offsetX, y: 70 - offsetY))
        path.addLine(to: CGPoint(x: 9 - offsetX, y: 74 - offsetY))
        path.closeSubpath()
        playerPlane.physicsBody = SKPhysicsBody(polygonFrom: path)
       
       
        //playerPlane.physicsBody = SKPhysicsBody(texture: playerPlaneTexture, alphaThreshold: 0.5, size: playerPlane.size)
        playerPlane.physicsBody?.isDynamic = false
        playerPlane.physicsBody?.categoryBitMask = BitMaskCategory.player.rawValue
        playerPlane.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue | BitMaskCategory.powerup.rawValue
        playerPlane.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue | BitMaskCategory.powerup.rawValue
        
        return playerPlane
    }

    
    func checkPosition() {
        self.position.x += xAcceleration * 50
        
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
       
        
    }
    
    func performFly() {
        
        // planeAnimationFillArray()
        preloadTextureArrays()
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
                
                
            }
        }
        
        let planeWaitAction = SKAction.wait(forDuration: 1.0)
        let planeDirectionCheckAction = SKAction.run { [unowned self] in
            self.movementDirectionCheck()
        }
        let planeSequence = SKAction.sequence([planeWaitAction,planeDirectionCheckAction])
        let planeSequenceForever = SKAction.repeatForever(planeSequence)
        self.run(planeSequenceForever)
        
    }
    
    
    fileprivate func preloadTextureArrays() {
        for i in 0...2 {
            self.preloadArray(_stride: animationSpriteStrides[i], callback: { [unowned self] array in
                switch i {
                case 0: self.leftTextureArrayAnimation = array
                case 1: self.rightTextureArrayAnimation = array
                case 2: self.forwardTextureArrayAnimation = array
                default:break
                
                }
            })
        }
    }
    
    fileprivate func preloadArray(_stride: (Int, Int, Int), callback: @escaping (_ array: [SKTexture]) -> ()) {
        
        var array = [SKTexture]()
        for i in stride(from: _stride.0, through: _stride.1, by: _stride.2) {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
            array.append(texture)
        }
        SKTexture.preload(array) {
            callback(array)
        }
        
    }
    
//    fileprivate func planeAnimationFillArray() {
//
//        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) {
//
//            self.leftTextureArrayAnimation = {
//
//                var array = [SKTexture]()
//                for i in stride(from: 13, through: 1, by: -1) {
//                    let number = String(format: "%02d", i)
//                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
//                    array.append(texture)
//                }
//
//                SKTexture.preload(array, withCompletionHandler:  {
//                    print("preload is done")
//                })
//                return array
//            }()
//        }
//
//
//          self.rightTextureArrayAnimation = {
//
//              var array = [SKTexture]()
//              for i in stride(from: 13, through: 26, by: 1) {
//                  let number = String(format: "%02d", i)
//                  let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
//                  array.append(texture)
//              }
//
//              SKTexture.preload(array, withCompletionHandler:  {
//                  print("preload is done")
//              })
//              return array
//          }()
//
//
//          self.forwardTextureArrayAnimation = {
//
//              var array = [SKTexture]()
//              let texture = SKTexture(imageNamed: "airplane_3ver2_13")
//                  array.append(texture)
//
//
//              SKTexture.preload(array, withCompletionHandler:  {
//                  print("preload is done")
//              })
//              return array
//          }()
//    }
    
    
    fileprivate func movementDirectionCheck() {
        
        if xAcceleration > 0.04, moveDirection != .right, stillTurning == false {
            
            stillTurning = true
            moveDirection = .right
            turnPlance(direction: .right)
            
        } else if xAcceleration < -0.04, moveDirection != .left, stillTurning == false{
            stillTurning = true
            moveDirection = .left
            turnPlance(direction: .left)
            
        } else if stillTurning == false {
            turnPlance(direction: .none)
        }
    }
    
    fileprivate func turnPlance(direction: TurnDirection) {
        var array = [SKTexture]()
        
        if direction == .right {
            array = rightTextureArrayAnimation
        } else if direction == .left {
            array = leftTextureArrayAnimation
        } else {
            array = forwardTextureArrayAnimation
        }
        
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.05, resize: true, restore: false)
        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)
        let sequenceAction = SKAction.sequence([forwardAction,backwardAction])
        self.run(sequenceAction) { [unowned self] in
            self.stillTurning = false
        }
        
    }
    
    func greenPowerUp() {
        let colorAction = SKAction.colorize(with: .green, colorBlendFactor: 1.0, duration: 0.2)
        let uncolorAction = SKAction.colorize(with: .green, colorBlendFactor: 0.0, duration: 0.2)
        let sequenceAction = SKAction.sequence([colorAction,uncolorAction])
        let repeatAction = SKAction.repeat(sequenceAction, count: 5)
        self.run(repeatAction)
    }
    
    func bluePowerUp() {
        let colorAction = SKAction.colorize(with: .blue, colorBlendFactor: 1.0, duration: 0.2)
        let uncolorAction = SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.2)
        let sequenceAction = SKAction.sequence([colorAction,uncolorAction])
        let repeatAction = SKAction.repeat(sequenceAction, count: 5)
        self.run(repeatAction)
    }
    
}

enum TurnDirection {
    case left
    case right
    case none
}














