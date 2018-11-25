//
//  CollaborationsDataResponse.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 25/11/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import ObjectMapper

class CollaborationsDataResponse : DefaultDataResponse {
    
    var collaborations: Array<Collaboration>?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.collaborations <- map["collaborations"]
    }
    
}
