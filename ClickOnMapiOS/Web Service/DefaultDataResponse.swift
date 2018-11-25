//
//  DefaultDataResponse.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 22/11/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import ObjectMapper

class DefaultDataResponse : Mappable {
    
    var tag: String?
    var success: Int?
    var error: Int?
    var error_msg: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        tag <- map["tag"]
        success <- map["success"]
        error <- map["error"]
        error_msg <- map["error_msg"]
    }
}
