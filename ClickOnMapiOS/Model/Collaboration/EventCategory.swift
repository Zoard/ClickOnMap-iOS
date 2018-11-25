//
//  EventCategory.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 18/10/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import ObjectMapper

class EventCategory : Mappable {
    
    var id: Int?
    var description: String?
    var eventType: Array<EventType>?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.description <- map["description"]
        self.eventType <- map["eventTypes"]
    }
}
