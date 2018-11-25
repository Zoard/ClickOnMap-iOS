//
//  UserService.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 18/10/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import Firebase

class UserService : ClickOnMapAPI, UserAPI {
    
    override init(baseUrl: String) {
        let newBaseUrl = baseUrl + "mobile/"
        super.init(baseUrl: newBaseUrl)
    }
    
    func sendUser(user: User, completionHandler: @escaping (DefaultDataResponse?) -> Void) {
        
        let url = self.baseUrl
        var responseApi: DefaultDataResponse?
        guard let fcmToken = Messaging.messaging().fcmToken else {
            return
        }
        let parameters = ["tag" : Tag.sendUser.rawValue, "email" : user.email,
                          "name" : user.name, "password" : user.password, "type" : user.type,
                          "registerDate" : Date().serverFormat(), "firebaseKey" : fcmToken] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseObject {
            (response: DataResponse<DefaultDataResponse>) in
            
            switch response.result {
            case .success:
                responseApi = response.result.value
                completionHandler(responseApi)
                break
                
            case .failure:
                completionHandler(responseApi)
                break
            }
            
        }

    }
    
    func verifyUser(email: String, password: String, completionHandler: @escaping (DefaultDataResponse?) -> Void) {
        
        let url = self.baseUrl
        var responseApi: DefaultDataResponse?
        guard let fcmToken = Messaging.messaging().fcmToken else {
            return
        }
        let parameters = ["tag" : Tag.verifyUser.rawValue, "email" : email, "password" : password,
                          "firebaseKey" : fcmToken] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseObject {
            (response: DataResponse<DefaultDataResponse>) in
            
            switch response.result {
            case .success:
                responseApi = response.result.value
                completionHandler(responseApi)
                break
                
            case .failure:
                completionHandler(responseApi)
                break
            }
            
        }
    }
    
    func requestUser(email: String, completionHandler: @escaping (UserDataResponse?) -> Void) {
        
        let url = self.baseUrl
        var responseApi: UserDataResponse?
        let parameters = ["tag" : Tag.requestUser.rawValue, "email" : email] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseObject {
            (response: DataResponse<UserDataResponse>) in
            
            switch response.result {
            case .success:
                responseApi = response.result.value
                completionHandler(responseApi)
                break
                
            case .failure:
                completionHandler(responseApi)
                break
            }
            
        }
    }

}
