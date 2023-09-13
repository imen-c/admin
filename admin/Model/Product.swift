//
//  Product.swift
//  admin
//
//  Created by imen cheref on 07/09/2023.
//

import Foundation

public class Product: Decodable, Encodable{
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case quantity
        case sizeS
        case sizeM
        case sizeL
        case sizeXL
        case sizeXXL
        case price
        case imageUrl
        case description
        case imageName
        case category
        case image64
       // case categoryId
        
    }
    
    
    var id : Int?
    var name: String
    var quantity: Int
    var sizeS: Int = 0
    var sizeM: Int = 0
    var sizeL: Int = 0
    var sizeXL: Int = 0
    var sizeXXL: Int = 0
   // var price: Float? = 0.0
    var price: Float?
    var imageUrl: String?
    var imageName: String?
    var description: String?
    var category: Category? = nil
    //var categoryId: Int?
    var isActive: Bool?
    var image64: String?
    

    init(name: String? = nil, quantity: Int? = nil, sizeS: Int? = nil, sizeM:Int? = nil , sizeL: Int? = nil, sizeXL: Int? = nil, sizeXXL :Int? = nil, price: Float? = nil, imageUrl: String? = nil,imageName: String? = nil,image64: String? = nil, description: String? = nil,category: Category? = nil ){
        self.name = name ?? ""
        self.quantity = quantity ?? 0
        self.sizeS = sizeS ?? 0
        self.sizeM = sizeM ?? 0
        self.sizeL = sizeL ?? 0
        self.sizeXL = sizeXL ?? 0
        self.sizeXXL = sizeXXL ?? 0
        self.price = price
       // if let price = price{
         //   self.price = String(price)        }
        
        self.imageUrl = imageUrl
        self.imageName = imageName
        self.image64 = image64
        self.category = category
        self.description = description
                
    }

    
     public  func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(name, forKey: .name)
           try container.encode(quantity, forKey: .quantity)
           try container.encode(sizeS, forKey: .sizeS)
           try container.encode(sizeM, forKey: .sizeM)
           try container.encode(sizeL, forKey: .sizeL)
           try container.encode(sizeXL, forKey: .sizeXL)
           try container.encode(sizeXXL, forKey: .sizeXXL)
           try container.encode(price, forKey: .price)
           try container.encode(imageUrl, forKey: .imageUrl)
           try container.encode(description, forKey: .description)
           try container.encode(imageName, forKey: .imageName)
           //try container.encode(categoryId, forKey: .categoryId)
       }


  
    
}
