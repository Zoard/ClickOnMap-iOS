//
//  SystemTile.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 11/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation

class SystemTile : Tile {
    
    let vgiSystem: VGISystem
    var available: Bool
    
    init(vgiSystem: VGISystem, available: Bool) {
        self.vgiSystem = vgiSystem
        self.available = available
    }
    
}
