//
//  Address.swift
//  admin
//
//  Created by imen cheref on 26/09/2023.
//

import Foundation
class Address: Decodable{
    
    var id : Int?
    var addressLine: String?
    var postalCode: String?
    var city: String?
    var country: String?
    
}
