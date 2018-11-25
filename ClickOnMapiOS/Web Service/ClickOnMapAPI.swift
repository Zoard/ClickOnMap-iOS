//
//  ClickOnMapAPI.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 18/10/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ClickOnMapAPI {
    
    let baseUrl: String
    
    enum Tag: String {
        case sendFirebaseKey = "send"
        case requestVGISystems = "getVGISystem"
        case sendMobileSystem = "sendMobileSystem"
        case requestVGISystemCategories = "getCategories"
        case sendUser = "insertUser"
        case verifyUser = "verifyUser"
        case requestUser = "getUser"
        case sendCollaboration = "collaboration"
        case requestCollaborations = "getCollaborations"
    }
    
    init(baseUrl: String = "http://www.ide.ufv.br/clickonmapserver/") {
        self.baseUrl = baseUrl
    }
    
}

protocol FirebaseAPI {
    func sendFirebaseKey(firebaseKey: String,
                         creationDate: String,
                         completionHandler: @escaping((DefaultDataResponse?) -> Void))
}

protocol VGISystemAPI {
    func sendMobileSystem(systemAddress: String,
                          firebaseKey: String,
                          completionHandler: @escaping(DefaultDataResponse?) -> Void)
    
    func requestVGISystems(completionHandler: @escaping(VGISystemDataResponse?) -> Void)
    
    func requestVGISystemCategories(completionHandler: @escaping(EventCategoryDataResponse?) -> Void)
}

protocol UserAPI {
    
    func sendUser(user: User, completionHandler: @escaping(DefaultDataResponse?) -> Void)
    
    func verifyUser(email: String, password: String, completionHandler: @escaping(DefaultDataResponse?) -> Void)
    
    func requestUser(email: String, completionHandler: @escaping(UserDataResponse?) -> Void)
    
}

protocol CollaborationAPI {
    
    func sendCollaboration(collaboration: Collaboration,
                           completionHandler : @escaping(DefaultDataResponse?) -> Void)
    
    func requestCollaborations(completionHandler: @escaping(CollaborationsDataResponse?) -> Void)
    
    //TODO: SENDING COLLABORATIONS WITH MIDIA
    
}
