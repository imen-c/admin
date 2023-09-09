//
//  DataManager.swift
//  admin
//
//  Created by imen cheref on 06/09/2023.
//

import Foundation
import SwiftyJSON


final class DataManager{
    
    static let instance : DataManager = {
        let instance = DataManager()
        return instance
    }()
    
    private init() {
    }
    
    func getProducts(completion: @escaping ([Product]?) -> Void){
        ApiService.instance.getProduct { result in
            switch result {
            case .success(let productList):
                
                print(productList)
                completion(productList)
                print("📗 Get Products DATAMANAGER")
                
            case .failure(let error):
                
                print("Erreur: \(error.localizedDescription)")
            }
        }
    }
    func deleteOneProduct(id: Int, completion: @escaping (MessageJson?) -> Void){
        ApiService.instance.deleteOneProduct(id: id) {response in
           
                switch response{
                case .success(let response):
                    print("📗 Success Delete Product")
                    completion(response)
                    
                case .failure(let error):
                    print("Erreur: \(error.localizedDescription)")
                    completion(nil)
                }
        }
    }
    
    
}