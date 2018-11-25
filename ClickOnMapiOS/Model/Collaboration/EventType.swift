//
//  EventType.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 18/10/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import ObjectMapper

class EventType: Mappable {
    
    var id: Int?
    var description: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
    }
}
