//
//  VGISystem.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit

class VGISystem {
    
    let address: String
    let name: String
    let description: String
    let color: UIColor
    //let category: Array<EventCategory>
    let collaborations: Int
    let latX: Double
    let latY: Double
    let lngX: Double
    let lngY: Double
    
    init(address: String, name: String, description: String, color: UIColor, collaborations: Int, latX: Double, latY: Double, lngX: Double, lngY: Double) {
        self.address = address
        self.name = name
        self.description = description
        self.color = color
        self.collaborations = collaborations
        self.latX = latX
        self.latY = latY
        self.lngX = lngX
        self.lngY = lngY
    }
    
}
