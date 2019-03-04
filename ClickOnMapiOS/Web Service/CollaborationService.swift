//
//  CollaborationService.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 24/11/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class CollaborationService : ClickOnMapAPI, CollaborationAPI {
    
    override init(baseUrl: String) {
        super.init(baseUrl: baseUrl)
    }
    
    func sendCollaboration(collaboration: Collaboration,
                           completionHandler: @escaping (DefaultDataResponse?) -> Void) {
        
        let url = self.baseUrl + "/mobile/"
        var responseApi: DefaultDataResponse?
        var tagImage = "N"
        var tagVideo = "N"
        if collaboration.photo != "" {
            tagImage = "Y"
        }
        if collaboration.video != ""{
            tagVideo = "Y"
        }
        
        let parameters = ["tag" : Tag.sendCollaboration.rawValue, "tagImage" : tagImage,
                          "tagVideo" : tagVideo, "userId" : collaboration.userId,
                          "title" : collaboration.title, "description" : collaboration.collaborationDescription,
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
        
        let url = self.baseUrl + "/mobile/"
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
    
    func requestCollaborationMidia(midiaPath: String, completionHandler: @escaping (UIImage?) -> Void) {
        let url = self.baseUrl + midiaPath
        print(url)
        
        Alamofire.request(url).responseImage { response in
            
            print(response.request as Any)
            print(response.response as Any)
            debugPrint(response.result)
            
            if let image = response.result.value {
                completionHandler(image)
                print("image downloaded: \(image)")
            }
            
        }
    }

    
    
}
