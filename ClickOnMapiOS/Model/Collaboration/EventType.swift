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
    
    @objc dynamic var realmId: String = UUID().description
    @objc dynamic var id: String = ""
    @objc dynamic var typeDescription: String = ""
    
    override static func primaryKey() -> String? {
        return "realmId"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.typeDescription <- map["description"]
    }
    
    // MARK: - Realm Methods
    
    static func add(in realm: Realm = try! Realm(), new subcategory: EventType) {
        try! realm.write {
            print("CATEGORY_ADD")
            realm.add(subcategory)
            try realm.commitWrite()
        }
    }
    
    static func all(in realm: Realm = try! Realm()) -> Results<EventType> {
        return realm.objects(EventType.self)
    }
    
    static func search(in realm: Realm = try! Realm(), for subcategory: EventType) -> EventType? {
        return realm.object(ofType: EventType.self, forPrimaryKey: subcategory.realmId)
    }
    
    static func update(in realm: Realm = try! Realm(), _ subcategory: EventType) {
        try! realm.write {
            realm.add(subcategory, update: true)
        }
    }
    
    static func delete(in realm: Realm = try! Realm(), _ subcategory: EventType) {
        try! realm.write {
            realm.delete(subcategory)
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
