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
    func addOneProduct(product: Product,catId : Int, completion: @escaping (Swift.Result<MessageJson, Error>) -> Void) {
        print("⬇️ Send One Product")
        let url = endpoint + "productCreate"
        
        let payload = ["name": product.name, "quantity" : product.quantity, "sizeS": product.sizeS, "sizeM": product.sizeM, "sizeL": product.sizeL, "sizeXL": product.sizeXL, "sizeXXL": product.sizeXXL, "price": String(product.price ?? 0.0), "imageUrl": product.imageUrl!, "description": product.description!, "imageName":product.imageName as Any,"categoryId": catId] as [String : Any]
        
        AF.request(url, method: .post, parameters: payload, encoding: JSONEncoding.default).responseDecodable(of: MessageJson.self)
        { response in
            switch response.result {
            case .success(let addResponse):
                completion(.success(addResponse))
                print("Ajout réussi")
            case .failure(let error):
                
                print("Erreur d ajout : \(error)")
                if let serverError = error as? AFError, let responseCode = serverError.responseCode {
                    print("Code de réponse du serveur : \(responseCode)")
                    print("Message d'erreur du serveur : \(serverError.localizedDescription)")
                } else {
                    print("Erreur inconnue : \(error.localizedDescription)")
                }
            }
        }
    }
    func editProduct(product: Product,catId : Int, completion: @escaping (Swift.Result<MessageJson, Error>) -> Void) {
        print("⬇️ Edit Product")
        let url = endpoint + "productUpdate"
        
        let payload = ["id" : product.id , "name": product.name, "quantity" : product.quantity, "sizeS": product.sizeS, "sizeM": product.sizeM, "sizeL": product.sizeL, "sizeXL": product.sizeXL, "sizeXXL": product.sizeXXL, "price": String(product.price ?? 0.0), "image64": product.image64 ?? "", "description": product.description ?? "","isActive": product.isActive, "imageName":product.imageName as Any,"categoryId": catId] as [String : Any]
        
        AF.request(url, method: .put, parameters: payload, encoding: JSONEncoding.default).responseDecodable(of: MessageJson.self)
        { response in
            switch response.result {
            case .success(let addResponse):
                completion(.success(addResponse))
                print("Modification réussie")
            case .failure(let error):
                
                print("Erreur d ajout : \(error)")
                if let serverError = error as? AFError, let responseCode = serverError.responseCode {
                    print("Code de réponse du serveur : \(responseCode)")
                    print("Message d'erreur du serveur : \(serverError.localizedDescription)")
                } else {
                    print("Erreur inconnue : \(error.localizedDescription)")
                }
            }
        }
    }

    

    func sendReport(report: Product, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        print("⬇️ Send Imaaaggge")

        print("⬇️ Upload Image")
        let url = endpoint + "uploadImage"
        AF.request(url, method: .post, parameters: report, encoder: JSONParameterEncoder.default).validate()
            .responseString(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    print(value)
                    completion(.success(value))
                case .failure(let error):
                    //print(error.localizedDescription)
                    //print(value)
                    //completion(.failure(error))
                    if let data = response.data,
                                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                                  let message = json["message"] as? String {
                                   completion(.failure(NSError(domain: "ServerError", code: 1, userInfo: [NSLocalizedDescriptionKey: message])))
                               } else {
                                   completion(.failure(error))
                               }
            }
        })
    }
    
    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void){
        
        print("⬇️ Upload Image")
        let url = endpoint + "uploadImage"
        
        AF.upload(multipartFormData: { multipartFormData in
            
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }
            
        }, to: url).responseData{ response in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = json["message"] as? String {
                    completion(.success(message))
                } else {
                    
                    completion(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: nil)))
                }
            case .failure(let error):
               // completion(.failure(error))
                if let data = response.data,
                              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                              let message = json["message"] as? String {
                               completion(.failure(NSError(domain: "ServerError", code: 1, userInfo: [NSLocalizedDescriptionKey: message])))
                           } else {
                               completion(.failure(error))
                           }
            }
        }
    }
    
    func getAllMessages(completion:@escaping(Result<[Message], Error>) ->Void){
        let url = endpoint + "getAllMessages"
        
        AF.request(url, method: .get).responseDecodable(of:[Message].self) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(.success(json.rawValue as! [Message]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func markIsRead(id : Int, completion: @escaping (Swift.Result<MessageJson, Error>) -> Void) {
        print("⬇️ Mark is Read Message")
        let url = endpoint + "markIsRead"
        
        let payload = ["id" : id ] as [String : Int]
        
        
        AF.request(url, method: .put, parameters: payload, encoding: JSONEncoding.default).responseDecodable(of: MessageJson.self)
        { response in
            switch response.result {
            case .success(let addResponse):
                completion(.success(addResponse))
                print("Modification réussie")
            case .failure(let error):
                
                print("Erreur d ajout : \(error)")
                if let serverError = error as? AFError, let responseCode = serverError.responseCode {
                    print("Code de réponse du serveur : \(responseCode)")
                    print("Message d'erreur du serveur : \(serverError.localizedDescription)")
                } else {
                    print("Erreur inconnue : \(error.localizedDescription)")
                }
            }
        }
    }
    
    func sendMessageResponse(id : Int,message: String, completion: @escaping (Swift.Result<MessageJson, Error>) -> Void) {
        print("⬇️ SEND  Message  Response")
        let url = endpoint + "sendAdminResponse"
        
        let payload = ["id" : id, "responseContent": message ] as [String : Any]
        
        
        AF.request(url, method: .put, parameters: payload, encoding: JSONEncoding.default).responseDecodable(of: MessageJson.self)
        { response in
            switch response.result {
            case .success(let addResponse):
                completion(.success(addResponse))
                print("Modification réussie")
            case .failure(let error):
                
                print("Erreur d ajout : \(error)")
                if let serverError = error as? AFError, let responseCode = serverError.responseCode {
                    print("Code de réponse du serveur : \(responseCode)")
                    print("Message d'erreur du serveur : \(serverError.localizedDescription)")
                } else {
                    print("Erreur inconnue : \(error.localizedDescription)")
                }
            }
        }
    }
    
    func deleteOneMessage(id: Int, completion:@escaping(Result<MessageJson ,Error>)->Void){
        let url = endpoint + "deleteMessage"
        let parameters: [String: Any] = ["id": id]
        
        
        AF.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: MessageJson.self)
        { response in
            switch response.result {
            case .success(let deleteResponse):
                completion(.success(deleteResponse))
                print("Suppression message réussie")
            case .failure(let error):
                
                print("Erreur de suppression : \(error)")
            }
        }
        
    }
    func getAllUsers(completion:@escaping(Result<[User], Error>) ->Void){
        let url = endpoint + "getAllUsersForAdmin"
        
        AF.request(url, method: .get).responseDecodable(of:[User].self) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(.success(json.rawValue as! [User]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getAllOrders(completion:@escaping(Result<OrderData, Error>) ->Void){
        let url = endpoint + "getAllOrdersForAdmin"
        
        AF.request(url, method: .get).responseDecodable(of:OrderData.self) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllStateOrder(completion:@escaping(Result<[StateOrder], Error>) ->Void){
        let url = endpoint + "getAllStateOrder"
        
        AF.request(url, method: .get).responseDecodable(of:[StateOrder].self) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func editOrder(orderId: Int,stateId : Int, completion: @escaping (Swift.Result<MessageJson, Error>) -> Void) {
        print("⬇️ Edit Order")
        let url = endpoint + "changeStateOrder"
        
        let payload = ["order" : orderId , "state": stateId]
        
        AF.request(url, method: .put, parameters: payload, encoding: JSONEncoding.default).responseDecodable(of: MessageJson.self)
        { response in
            switch response.result {
            case .success(let response):
                completion(.success(response))
                print("Modification réussie")
                print(response)
            case .failure(let error):
                
                print("Erreur d ajout : \(error)")

            }
        }
    }
    
    
    
}
