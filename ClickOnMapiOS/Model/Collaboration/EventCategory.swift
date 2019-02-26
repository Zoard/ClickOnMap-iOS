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
import ObjectMapper_Realm

class EventCategory : Object, Mappable {
    
    @objc dynamic var realmId: String = UUID().description
    @objc dynamic var id: String = ""
    @objc dynamic var categoryDescription: String = ""
    let subcategories = List<EventType>()
    var eventType: Array<EventType>?
    
    override static func primaryKey() -> String? {
        return "realmId"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.categoryDescription <- map["description"]
        self.eventType <- map["eventTypes"]
        self.set(new: eventType)
    }
    
    // MARK: - Methods
    
    func set(new eventTypes: Array<EventType>?) {
        guard let subcategories = eventTypes else {
            return
        }
        for subcategory in subcategories {
            self.subcategories.append(subcategory)
        }
    }
    
    // MARK: - Realm Methods
    
    static func add(in realm: Realm = try! Realm(), new category: EventCategory) {
        try! realm.write {
            print("CATEGORY_ADD")
            realm.add(category)
            try realm.commitWrite()
        }
    }
    
    static func all(in realm: Realm = try! Realm()) -> Results<EventCategory> {
        return realm.objects(EventCategory.self)
    }
    
    static func search(in realm: Realm = try! Realm(), for category: EventCategory) -> EventCategory? {
        return realm.object(ofType: EventCategory.self, forPrimaryKey: category.realmId)
    }
    
    static func update(in realm: Realm = try! Realm(), _ category: EventCategory) {
        try! realm.write {
            realm.add(category, update: true)
        }
    }
    
    static func delete(in realm: Realm = try! Realm(), _ category: EventCategory) {
        
        for subcategory in category.subcategories {
            EventType.delete(subcategory)
        }
        
        try! realm.write {
            realm.delete(category)
            try realm.commitWrite()
        }
    }
    
    static func deleteAll(in realm: Realm = try! Realm()) {
        try! realm.write {
            realm.deleteAll()
            try realm.commitWrite()
        }
    }
    
}
