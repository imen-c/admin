//
//  Order.swift
//  admin
//
//  Created by imen cheref on 20/09/2023.
//

import Foundation

class OrderData : Decodable{
    var totalOrdersToday: Int?
    var monthIncome: Double?
    var orders : [Order] = []
}

class Order : Decodable{
    
    var id: Int?
    var createdAt: String?
    var status = StateOrder()
    var customer = User()
    var address = Address()
    var orderLines : [OrderLine] = []
    
}

struct OrderLine : Decodable{
    
    var id: Int?
    var productName: String?
    var productImage: String?
    var qty: Int?
    var unitPrice: String?
    var subTotal: String?
    var chosenSize: String?
    var sizeS: Int = 0
    var sizeM: Int = 0
    var sizeL: Int = 0
    var sizeXL: Int = 0
    var sizeXXL: Int = 0
    
    
}
struct StateOrder : Decodable{
    var id : Int?
    var name : String?
}

