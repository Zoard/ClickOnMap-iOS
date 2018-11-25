//
//  VGISystem.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit
import ObjectMapper

class VGISystem : Mappable {
    
    var address: String?
    var name: String?
    var description: String?
    var color: UIColor?
    //var category: Array<EventCategory>?
    var collaborations: Int?
    var latX: Double?
    var latY: Double?
    var lngX: Double?
    var lngY: Double?
    
    required init?(map: Map) {
    
    }
    
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
    
    
    
    func mapping(map: Map) {
        self.address <- map["address"]
        self.name <- map["name"]
        self.description <- map["description"]
        self.color <- map["color"]
        self.collaborations <- map["collaborations"]
        self.latX <- map["latX"]
        self.latY <- map["latY"]
        self.lngX <- map["lngX"]
        self.lngY <- map["lngY"]
    }
    
}
