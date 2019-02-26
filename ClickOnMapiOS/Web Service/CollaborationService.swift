//
//  CollaborationService.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 24/11/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class CollaborationService : ClickOnMapAPI, CollaborationAPI {
    
    override init(baseUrl: String) {
        let newBaseUrl = baseUrl + "/mobile/"
        super.init(baseUrl: newBaseUrl)
    }
    
    func sendCollaboration(collaboration: Collaboration,
                           completionHandler: @escaping (DefaultDataResponse?) -> Void) {
        
        let url = self.baseUrl
        var responseApi: DefaultDataResponse?
        let parameters = ["tag" : Tag.sendCollaboration.rawValue, "tagImage" : collaboration.photo,
                          "tagVideo" : collaboration.video, "userId" : collaboration.userId,
                          "title" : collaboration.title, "description" : collaboration.description,
                          "idCategory" : collaboration.categoryId, "idType" : collaboration.subcategoryId,
                          "latitude" : collaboration.latitude, "longitude" : collaboration.longitude,
                          "date" : collaboration.collaborationDate] as [String : Any]
        
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
    
    func requestCollaborations(completionHandler: @escaping (CollaborationsDataResponse?) -> Void) {
        
        let url = self.baseUrl
        var responseApi: CollaborationsDataResponse?
        let parameters = ["tag" : Tag.requestCollaborations.rawValue] as [String : Any]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseObject {
            (response: DataResponse<CollaborationsDataResponse>) in
            
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
