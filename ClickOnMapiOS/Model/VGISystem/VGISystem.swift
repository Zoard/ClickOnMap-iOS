//
//  VGISystem.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class VGISystem : Object, Mappable {
    
    // MARK: - Attributes
    
    @objc dynamic var address: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var systemDescription: String = ""
    @objc dynamic var color: String = ""
    var category: List<EventCategory>?
    @objc dynamic var collaborations: Int = 0
    @objc dynamic var user: User?
    @objc dynamic var latX: Double = 0.0
    @objc dynamic var latY: Double = 0.0
    @objc dynamic var lngX: Double = 0.0
    @objc dynamic var lngY: Double = 0.0
    @objc dynamic var hasSession: Bool = false
    @objc dynamic var sync: Bool = false
    
    override static func primaryKey() -> String? {
        return "address"
    }
    
    // MARK: Initializers
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.address <- map["address"]
        self.name <- map["name"]
        self.systemDescription <- map["description"]
        self.color <- map["color"]
        self.collaborations <- map["collaborations"]
        self.latX <- map["latX"]
        self.latY <- map["latY"]
        self.lngX <- map["lngX"]
        self.lngY <- map["lngY"]
    }
    
    // MARK: - Realm Methods
    
    static func add(in realm: Realm = try! Realm(), new vgiSystem: VGISystem) {
        try! realm.write {
            realm.add(vgiSystem)
            try realm.commitWrite()
        }
    }
    
    static func all(in realm: Realm = try! Realm()) -> Results<VGISystem> {
        return realm.objects(VGISystem.self)
    }
    
    static func search(in realm: Realm = try! Realm(), for vgiSystem: VGISystem) -> VGISystem? {
        return realm.object(ofType: VGISystem.self, forPrimaryKey: vgiSystem.address)
    }
    
}
