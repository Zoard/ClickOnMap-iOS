//
//  Collaboration.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 05/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import ObjectMapper

class Collaboration : Mappable {
    
    var collaborationId: Int = 0
    var userId: String = ""
    var userName: String = ""
    var title: String = ""
    var description: String = ""
    var collaborationDate: String = ""
    var categoryId: Int = 0
    var categoryName: String = ""
    var subcategoryId: Int = 0
    var subcategoryName: String = ""
    var photo: String = ""
    var video: String = ""
    var audio: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    
    init(collaborationId: Int, userId: String, userName: String, title: String, description: String, collaborationDate: String,
         categoryId:Int, categoryName: String, subcategoryId: Int , subcategoryName: String, photo: String, video: String, audio: String,
         latitude: Double , longitude: Double) {
        
        self.collaborationId = collaborationId
        self.userId = userId
        self.userName = userName
        self.title = title
        self.description = description
        self.collaborationDate = collaborationDate
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.subcategoryId = subcategoryId
        self.subcategoryName = subcategoryName
        self.photo = photo
        self.video = video
        self.audio = audio
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.collaborationId <- map["collaborationId"]
        self.userId <- map["userId"]
        self.userName <- map["userName"]
        self.title <- map["title"]
        self.description <- map["description"]
        self.collaborationDate <- map["collaborationDate"]
        self.categoryId <- map["categoryId"]
        self.categoryName <- map["categoryName"]
        self.subcategoryId <- map["subcategoryId"]
        self.subcategoryName <- map["subcategoryName"]
        self.photo <- map["photo"]
        self.video <- map["video"]
        self.audio <- map["audio"]
        self.latitude <- map["latitude"]
        self.longitude <- map["longitude"]
    }
    
}
