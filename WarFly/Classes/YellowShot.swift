//
//  YellowShot.swift
//  WarFly
//
//  Created by Alex Alexandro on 16.03.2021.
//

import SpriteKit

class YellowShot: Shot {
    
    init() {
        
        let textureAtlas = Assets.shared.yellowAmmoAtlas //SKTextureAtlas(named: "YellowAmmo")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
