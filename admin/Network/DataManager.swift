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
    
    
}
