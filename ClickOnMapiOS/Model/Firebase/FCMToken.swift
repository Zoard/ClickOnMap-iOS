//
//  FcmToken.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 25/11/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import RealmSwift

class FCMToken : Object {
    
    @objc dynamic var fcmKey: String = ""
    @objc dynamic var creationDate: String = ""
    
    override static func primaryKey() -> String? {
        return "fcmKey"
    }
    
}
