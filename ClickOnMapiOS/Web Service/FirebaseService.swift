//
//  FirebaseService.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 18/10/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class FirebaseService : ClickOnMapAPI, FirebaseAPI {
        
    init() {
        super.init()
    }
    
    override init(baseUrl: String) {
        super.init(baseUrl: baseUrl)
    }
        
    func sendFirebaseKey(firebaseKey: String, creationDate: String,
                         completionHandler: @escaping ((DefaultDataResponse?) -> Void)) {
        
        let url = self.baseUrl + "FCM/"
        var responseApi: DefaultDataResponse?
        let parameters = ["tag" : Tag.sendFirebaseKey.rawValue, "firebaseKey" : firebaseKey,
                          "creationDate" : creationDate] as [String : Any]
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
    
}
