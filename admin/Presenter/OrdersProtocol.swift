//
//  OrdersProtocol.swift
//  admin
//
//  Created by imen cheref on 24/09/2023.
//

import Foundation


protocol OrdersProtocol: NSObjectProtocol{
    
    func OnGetAllOrdersSuccess(response : OrderData)
    func OnGetAllOrdersError()
    
    func OnGetAllStateSuccess(response : [StateOrder])
    func OnGetAllSateError()
    

    
    
}
