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
    
    func addOneProduct(product: Product,catId: Int,  completion: @escaping (MessageJson?) -> Void){
        ApiService.instance.addOneProduct(product: product,catId: catId, completion: { response in
            switch response{
            case .success(let response):
                completion(response)
            case .failure( _):
                completion(nil)
            }
        })
    }
    func editProduct(product: Product,catId: Int,  completion: @escaping (MessageJson?) -> Void){
        ApiService.instance.editProduct(product: product,catId: catId, completion: { response in
            switch response{
            case .success(let response):
                completion(response)
            case .failure( _):
                completion(nil)
            }
        })
    }
    
    func uploadImage(product: Product,  completion: @escaping (String?) -> Void){
        ApiService.instance.sendReport(report: product, completion: { response in
            switch response{
            case .success(let response):
                completion(response)
            case .failure( _):
                completion(nil)
            }
        })
    }
    
    func getAllMessages(completion: @escaping ([Message]?) -> Void){
        ApiService.instance.getAllMessages { result in
            switch result {
            case .success(let messageList):
                
                
                completion(messageList)
                print("📗 Get message DATAMANAGER")
                
            case .failure(let error):
                
                print("Erreur get messages: \(error.localizedDescription)")
            }
        }
    }
    func markIsRead(id: Int,  completion: @escaping (MessageJson?) -> Void){
        ApiService.instance.markIsRead(id: id, completion: { response in
            switch response{
            case .success(let response):
                completion(response)
            case .failure( _):
                completion(nil)
            }
        })
    }
    
    
}
