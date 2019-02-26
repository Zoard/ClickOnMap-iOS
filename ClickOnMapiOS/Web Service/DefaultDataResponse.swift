//
//  DefaultDataResponse.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 22/11/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class DefaultDataResponse : Mappable {
    
    var tag: String = ""
    var success: Int = 0
    var error: Int = 0
    var error_msg: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.tag <- map["tag"]
        self.success <- map["success"]
        self.error <- map["error"]
        self.error_msg <- map["error_msg"]
    }
}
