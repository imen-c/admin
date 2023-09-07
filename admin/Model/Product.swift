//
//  Product.swift
//  admin
//
//  Created by imen cheref on 07/09/2023.
//

import Foundation

struct Product: Decodable{
    
    
    var id : Int?
    var name: String
    var quantity: Int
    var sizeS: Int = 0
    var sizeM: Int = 0
    var sizeL: Int = 0
    var sizeXL: Int = 0
    var sizeXXL: Int = 0
    var price: String?
    var imageUrl: String?
    var category: Category? = nil
    
    
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decodeIfPresent(Int.self, forKey: .id)
//        name = try container.decodeIfPresent(String.self, forKey: .name)
//        quantity = try container.decodeIfPresent(Int.self, forKey: .quantity)
//        sizeS = try container.decodeIfPresent(Int.self, forKey: .sizeS)
//        sizeM = try container.decodeIfPresent(Int.self, forKey: .sizeM)
//        sizeL = try container.decodeIfPresent(Int.self, forKey: .sizeL)
//        sizeXL = try container.decodeIfPresent(Int.self, forKey: .sizeXL)
//        sizeXXL = try container.decodeIfPresent(Int.self, forKey: .sizeXXL)
//        price = try container.decodeIfPresent(String.self, forKey: .price)
//        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
//        category = try container.decodeIfPresent(Category.self, forKey: .category)
//
//}





    
    
    
    
    
    
}
