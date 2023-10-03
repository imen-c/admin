//
//  LoginResponse.swift
//  admin
//
//  Created by imen cheref on 03/10/2023.
//

import Foundation

class LoginResponse: Decodable{
    
    
    var token: String?
    var refresh_token : String?
    
}

class MessageLogin: Decodable{
    
    var status = false
}
