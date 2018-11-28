//
//  User.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 18/10/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class User : Object, Mappable {
    
    // MARK: Attributes
    
    @objc dynamic var id: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var registerDate: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: - Initializers
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        email <- map["email"]
        name <- map["name"]
        password <- map["password"]
        type <- map["type"]
        registerDate <- map["registerDate"]
    }
    
    // MARK: - Methods
    
    func setAttributes(id: String, email: String, name: String, password: String, type: String,
                       registerDate: String) {
        self.id = id
        self.email = email
        self.name = name
        self.password = password
        self.type = type
        self.registerDate = registerDate
        
    }
    
}
