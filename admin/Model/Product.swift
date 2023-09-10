//
//  Product.swift
//  admin
//
//  Created by imen cheref on 07/09/2023.
//

import Foundation

struct Product: Decodable{
    
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case quantity
//        case sizeS
//        case sizeM
//        case sizeL
//        case sizeXL
//        case sizeXXL
//        case price
//        case imageUrl
//        case category
//    }
//
    
    
    var id : Int?
    var name: String
    var quantity: Int
    var sizeS: Int = 0
    var sizeM: Int = 0
    var sizeL: Int = 0
    var sizeXL: Int = 0
    var sizeXXL: Int = 0
   // var price: Float? = 0.0
    var price: String?
    var imageUrl: String?
    var description: String?
    var category: Category? = nil
    var isActive: Bool?
    

    init(name: String? = nil, quantity: Int? = nil, sizeS: Int? = nil, sizeM:Int? = nil , sizeL: Int? = nil, sizeXL: Int? = nil, sizeXXL :Int? = nil, price: Float? = nil, imageUrl: String? = nil,category: Category? = nil ){
        self.name = name ?? ""
        self.quantity = quantity ?? 0
        self.sizeS = sizeS ?? 0
        self.sizeM = sizeM ?? 0
        self.sizeL = sizeL ?? 0
        self.sizeXL = sizeXL ?? 0
        self.sizeXXL = sizeXXL ?? 0
        //self.price = price
        self.imageUrl = imageUrl
        self.category = category
        
        
        
        
        
    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decodeIfPresent(Int.self, forKey: .id)
//        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
//        quantity = try container.decodeIfPresent(Int.self, forKey: .quantity) ?? 0
//        sizeS = try container.decodeIfPresent(Int.self, forKey: .sizeS) ?? 0
//        sizeM = try container.decodeIfPresent(Int.self, forKey: .sizeM) ?? 0
//        sizeL = try container.decodeIfPresent(Int.self, forKey: .sizeL) ?? 0
//        sizeXL = try container.decodeIfPresent(Int.self, forKey: .sizeXL) ?? 0
//        sizeXXL = try container.decodeIfPresent(Int.self, forKey: .sizeXXL) ?? 0
//        price = try container.decodeIfPresent(Float.self, forKey: .price)
//        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
//        category = try container.decodeIfPresent(Category.self, forKey: .category)
//
//}
  
    
}
