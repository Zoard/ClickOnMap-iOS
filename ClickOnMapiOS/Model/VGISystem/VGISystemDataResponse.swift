//
//  VGISystemDataResponse.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 24/11/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import ObjectMapper

class VGISystemDataResponse : DefaultDataResponse {
    
    var vgiSystems: Array<VGISystem>?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.vgiSystems <- map["vgiSystems"]
    }
    
}
