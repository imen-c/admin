//
//  ProductViewProtocol.swift
//  admin
//
//  Created by imen cheref on 08/09/2023.
//

import Foundation

protocol ProductViewProtocol : NSObjectProtocol{
    
    
    func OnGetProductSuccess(response: [Product])
    func OnGetProductError()
    

  
    
}
