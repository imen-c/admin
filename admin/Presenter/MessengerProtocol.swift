//
//  MessengerProtocol.swift
//  admin
//
//  Created by imen cheref on 15/09/2023.
//

import Foundation
protocol MessengerProtocol : NSObjectProtocol{
    
    
    func OnGetAllMessageSuccess(response: [Message])
    func OnGetAllMessageError()
    

    
    
    
}
