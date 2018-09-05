//
//  Collaboration.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 05/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation

class Collaboration {
    
    let collaborationId: Int
    let userId: String
    let userName: String
    let title: String
    let description: String
    let collaborationDate: String
    let categoryId: Int
    let categoryName: String
    let subcategoryId: Int
    let subcategoryName: String
    let photo: String
    let video: String
    let audio: String
    let latitude: Double
    let longitude: Double
    
    
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
    
}
