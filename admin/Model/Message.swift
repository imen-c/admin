//
//  Message.swift
//  admin
//
//  Created by imen cheref on 15/09/2023.
//

import Foundation

class Message: Decodable{
    
    var id: Int?
    var subject: String?
    var content: String?
    var isRead: Bool?
    var subjectNumber: Int?
    //var createdAt : DateBackend
    
    var response: Bool?
    var responseContent: String?
    var user: User
    
    
    
    
    
}
