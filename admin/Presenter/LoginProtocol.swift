//
//  LoginProtocol.swift
//  admin
//
//  Created by imen cheref on 03/10/2023.
//

import Foundation

protocol LoginProtocol: NSObjectProtocol{
    
    func OnConnexionSuccess(response : LoginResponse)
    func OnConnexionError()
    
    
    

    
    
}
