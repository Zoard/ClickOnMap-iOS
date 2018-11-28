//
//  EventType.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 18/10/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class EventType: Object, Mappable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var typeDescription: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.typeDescription <- map["description"]
    }
}
