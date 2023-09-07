//
//  ApiService.swift
//  admin
//
//  Created by imen cheref on 06/09/2023.
//

import Foundation
import Alamofire
import SwiftyJSON


final class ApiService{
    
    let endpoint = "https://localhost:8000/"
    
    static let instance : ApiService = {
        let instance = ApiService()
        return instance
    }()
//    let manager : Session
//
//    init(){
//        let configuration = URLSessionConfiguration.default
//        manager = Session(configuration: configuration, delegate: SessionDelegate())
//
//        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
//            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
//                return (.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
//            }
//            return (.performDefaultHandling, nil)
//        }
//
//
//    }
    
    
    func getProduct(completion:@escaping(Result<[Product], Error>) ->Void){
        let url = endpoint + "productAll"
        
        AF.request(url, method: .get).responseDecodable(of:[Product].self) { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        completion(.success(json.rawValue as! [Product]))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        
        
        
        
        
        
    }
    
    
    
    
}
