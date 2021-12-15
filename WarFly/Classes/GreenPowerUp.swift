//
//  GreenPowerUp.swift
//  WarFly
//
//  Created by Alex Alexandro on 16.03.2021.
//

import SpriteKit

class GreenPowerUp: PowerUp {
    
    init() {
        let textureAtlas = Assets.shared.greenPowerUpAtlas //SKTextureAtlas(named: "GreenPowerUp")
        super.init(textureAtlas: textureAtlas)
        name = "greenPowerUp"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
