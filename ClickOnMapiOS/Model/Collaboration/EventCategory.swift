//
//  EventCategory.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 18/10/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class EventCategory : Object, Mappable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var categoryDescription: String = ""
    var eventType: List<EventType>?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.categoryDescription <- map["description"]
        self.eventType <- map["eventTypes"]
    }
}
