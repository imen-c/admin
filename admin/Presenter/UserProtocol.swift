//
//  UserProtocol.swift
//  admin
//
//  Created by imen cheref on 17/09/2023.
//

import Foundation

protocol UserProtocol: NSObjectProtocol{
    
    func OnGetAllUsersSuccess(response : [User])
    func OnGetAllUsersError()
    

    
    
}
