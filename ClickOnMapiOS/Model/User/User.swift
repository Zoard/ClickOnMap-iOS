//
//  User.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 18/10/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import ObjectMapper

class User : Mappable {
    
    var id: String = ""
    var email: String = ""
    var name: String = ""
    var password: String = ""
    var type: Character = "C"
    var registerDate: String = ""
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        email <- map["email"]
        name <- map["name"]
        password <- map["password"]
        type <- map["type"]
        registerDate <- map["registerDate"]
    }
}
