//
//  BluePowerUp.swift
//  WarFly
//
//  Created by Alex Alexandro on 16.03.2021.
//

import SpriteKit

class BluePowerUp: PowerUp {
   
    init() {
        let textureAtlas = Assets.shared.bluePowerUpAtlas //SKTextureAtlas(named: "BluePowerUp")
        super.init(textureAtlas: textureAtlas)
        name = "bluePowerUp"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
