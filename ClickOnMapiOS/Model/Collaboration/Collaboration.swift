//
//  Collaboration.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 05/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class Collaboration : Object, Mappable {
    
    // MARK: - Attributes
    
    @objc dynamic var realmId: String = ""
    @objc dynamic var collaborationId: Int = 0
    @objc dynamic var userId: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var collaborationDescription: String = ""
    @objc dynamic var collaborationDate: String = ""
    @objc dynamic var categoryId: Int = 0
    @objc dynamic var categoryName: String = ""
    @objc dynamic var subcategoryId: Int = 0
    @objc dynamic var subcategoryName: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var video: String = ""
    @objc dynamic var audio: String = ""
    @objc dynamic var latitude: String = ""
    @objc dynamic var longitude: String = ""
    
    override static func primaryKey() -> String? {
        return "realmId"
    }
    
    // MARK: Initializers
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.collaborationId <- map["collaborationId"]
        self.userId <- map["userId"]
        self.userName <- map["userName"]
        self.title <- map["title"]
        self.collaborationDescription <- map["description"]
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
    
    // MARK: - Methods
    
    func set(realmId: String, userId: String, userName: String, title: String, collabDescription: String,
             collaborationDate: String, categoryId:Int, categoryName: String, subcategoryId: Int ,
             subcategoryName: String, photo: String, video: String, audio: String,
             latitude: String , longitude: String) {
        
        self.realmId = realmId
        self.userId = userId
        self.userName = userName
        self.title = title
        self.collaborationDescription = collabDescription
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
    
    // MARK: - Realm Methods
    
    static func add(in realm: Realm = try! Realm(), new collaboration: Collaboration) {
        try! realm.write {
            realm.add(collaboration)
            try realm.commitWrite()
        }
    }
    
    static func all(in realm: Realm = try! Realm()) -> Results<Collaboration> {
        return realm.objects(Collaboration.self)
    }
    
    static func search(in realm: Realm = try! Realm(), for collaboration: Collaboration) -> Collaboration? {
        return realm.object(ofType: Collaboration.self, forPrimaryKey: collaboration.realmId)
    }
    
    static func update(in realm: Realm = try! Realm(), _ collaboration: Collaboration) {
        realm.beginWrite()
        try! realm.write {
            realm.add(collaboration, update: true)
            try realm.commitWrite()
        }
    }
    
    static func delete(in realm: Realm = try! Realm(), _ collaboration: Collaboration) {
        try! realm.write {
            realm.delete(collaboration)
            try realm.commitWrite()
        }
    }
    
    static func deleteAll(in realm: Realm = try! Realm()) {
        let allCollaborations = realm.objects(Collaboration.self)
        try! realm.write {
            realm.delete(allCollaborations)
            try realm.commitWrite()
        }
    }
    
    
}
