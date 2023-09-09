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
    func deleteOneProduct(id: Int, completion:@escaping(Result<MessageJson ,Error>)->Void){
        let url = endpoint + "productDesactivate"
        let parameters: [String: Any] = ["id": id]
        
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: MessageJson.self)
        { response in
                switch response.result {
                case .success(let deleteResponse):
                    completion(.success(deleteResponse))
                    print("Suppression réussie")
                case .failure(let error):

                    print("Erreur de suppression : \(error)")
                }
            }
        
    }
}
