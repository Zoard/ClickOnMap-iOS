//
//  VGISystemService.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 24/11/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class VGISystemService : ClickOnMapAPI, VGISystemAPI {

    init() {
        super.init()
    }
    
    override init(baseUrl: String) {
        super.init(baseUrl: baseUrl)
    }
    
    func sendMobileSystem(systemAddress: String, firebaseKey: String,
                          completionHandler: @escaping (DefaultDataResponse?) -> Void) {
        
        let url = self.baseUrl + "VGISystem/"
        var responseApi: DefaultDataResponse?
        let parameters = ["tag" : Tag.sendMobileSystem.rawValue, "systemAddress" : systemAddress,
                          "firebaseKey" : firebaseKey] as [String : Any]
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
    
    func requestVGISystems(completionHandler: @escaping (VGISystemDataResponse?) -> Void) {
        
        let url = self.baseUrl + "VGISystem"
        print(url)
        var responseApi: VGISystemDataResponse?
        let parameters = ["tag" : Tag.requestVGISystems.rawValue] as [String : Any]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseObject {
            (response: DataResponse<VGISystemDataResponse>) in
            
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
    
    func requestVGISystemCategories(completionHandler: @escaping (EventCategoryDataResponse?) -> Void) {
        
        let url = self.baseUrl + "/mobile/"
        var responseApi: EventCategoryDataResponse?
        let parameters = ["tag" : Tag.requestVGISystemCategories.rawValue] as [String : Any]
        print(url)
        print(Tag.requestVGISystemCategories.rawValue)
        Alamofire.request(url, method: .get, parameters: parameters).responseObject {
            (response: DataResponse<EventCategoryDataResponse>) in
            
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
