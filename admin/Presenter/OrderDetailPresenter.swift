//
//  OrderDetailPresenter.swift
//  admin
//
//  Created by imen cheref on 25/09/2023.
//

import Foundation
class OrderDetailPresenter{
    
    
    weak var view : OrderDetailProtocol?
    
    init(view : OrderDetailProtocol){
        self.view = view
    }
    
    func editOrder(orderId: Int, stateId: Int){
        
        DataManager.instance.editOrder(orderId: orderId, stateId: stateId, completion: { response in
            guard response != nil else {
                self.view?.onEditOrderError()
                return
            }
            self.view?.onEditOrderSuccess()
        })
        
    }
    
    
    
    
    
}
