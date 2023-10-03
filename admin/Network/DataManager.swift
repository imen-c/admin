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
    func sendMessageResponse(id: Int,message: String,   completion: @escaping (MessageJson?) -> Void){
        ApiService.instance.sendMessageResponse(id: id, message: message, completion: { response in
            switch response{
            case .success(let response):
                completion(response)
            case .failure( _):
                completion(nil)
            }
        })
    }
    
    func deleteOneMessage(id: Int, completion: @escaping (MessageJson?) -> Void){
        ApiService.instance.deleteOneMessage(id: id,completion: { response in
            switch response{
            case .success(let response):
                completion(response)
            case .failure( _):
                completion(nil)
            }
        })
    }
    
    func getAllUsers(completion: @escaping ([User]?) -> Void){
        ApiService.instance.getAllUsers { result in
            switch result {
            case .success(let userList):
                
                
                completion(userList)
                print("📗 Get Users DATAMANAGER")
                
            case .failure(let error):
                
                print("Erreur get messages: \(error.localizedDescription)")
            }
        }
    }
    func getAllOrders(completion: @escaping (OrderData?) -> Void){
        ApiService.instance.getAllOrders { result in
            switch result {
            case .success(let orderList):
                
                
                completion(orderList)
                print("📗 Get Orders DATAMANAGER")
                
            case .failure(let error):
                
                print("Erreur get messages: \(error.localizedDescription)")
            }
        }
    }
    
    func getAllStateOrder(completion: @escaping ([StateOrder]?) -> Void){
        ApiService.instance.getAllStateOrder { result in
            switch result {
            case .success(let response):
                
                
                completion(response)
                print("📗 Get State DATAMANAGER")
                
            case .failure(let error):
                
                print("Erreur get state: \(error.localizedDescription)")
            }
        }
    }
    
    func editOrder(orderId: Int, stateId: Int,  completion: @escaping (MessageJson?) -> Void){
        ApiService.instance.editOrder(orderId: orderId,stateId: stateId, completion: { response in
            switch response{
            case .success(let response):
                completion(response)
            case .failure( _):
                completion(nil)
            }
        })
    }
    func getAllCategories(completion: @escaping ([Category]?) -> Void){
        ApiService.instance.getAllCategories() { result in
            switch result {
            case .success(let list):
                
                print(list)
                completion(list)
                print("📗 Get categories DATAMANAGER")
                
            case .failure(let error):
                
                print("Erreur: \(error.localizedDescription)")
            }
        }
    }
    
    func connectAdmin(login: String,password: String,  completion: @escaping (LoginResponse?) -> Void){
        ApiService.instance.connectAdmin(login: login,password: password, completion: { response in
            switch response{
            case .success(let response):
                completion(response)
            case .failure( _):
                completion(nil)
            }
        })
    }

    
    
}
