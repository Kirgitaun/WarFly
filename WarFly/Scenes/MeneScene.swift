//
//  MeneScene.swift
//  WarFly
//
//  Created by Alex Alexandro on 16.03.2021.
//

import SpriteKit

class MeneScene: ParentScene {

    override func didMove(to view: SKView) {
        if !Assets.shared.isLoaded {
            Assets.shared.preloadAssets()
            Assets.shared.isLoaded = true
        }
        
        
        setHeader(withname: nil, andBackground: "header1")
//        let header = SKSpriteNode(imageNamed: "header1")
//        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
//        self.addChild(header)
        
        let titles = ["play", "options", "best"]
        
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(titled: title, backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
            button.name = title
            button.label.name = title
            addChild(button)
        }
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "play" {
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
        else if node.name == "options" {
            
            let transition = SKTransition.crossFade(withDuration: 1)
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
        }
        else if node.name == "best" {
            
            let transition = SKTransition.crossFade(withDuration: 1)
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(bestScene, transition: transition)
        }
    }
}


//        let button1 = ButtonNode(titled: "play", backgroundName: "button_background")
//        button1.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//        button1.name = "play"
//        button1.label.name = "play"
//        addChild(button1)
//
//        let button2 = ButtonNode(titled: "options", backgroundName: "button_background")
//        button2.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
//        button2.name = "options"
//        button2.label.name = "options"
//        addChild(button2)
//
//        let button3 = ButtonNode(titled: "best", backgroundName: "button_background")
//        button3.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200)
//        button3.name = "best"
//        button3.label.name = "best"
//        addChild(button3)
