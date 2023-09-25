//
//  OrdersPresenter.swift
//  admin
//
//  Created by imen cheref on 24/09/2023.
//

import Foundation

class OrdersPresenter{
    
    
    weak var view : OrdersProtocol?
    
    init(view : OrdersProtocol){
        self.view = view
    }
    
    func getAllOrders(){
        
        DataManager.instance.getAllOrders(completion: {
            response in
            guard let response = response else {
                self.view?.OnGetAllOrdersError()
                print("Error presentre")
                return
            }
            print("SUCCESS PRESENTER")
            self.view?.OnGetAllOrdersSuccess(response: response)
            
        })
    }
    func getAllStateOrder(){
        
        DataManager.instance.getAllStateOrder(completion: {
            response in
            guard let response = response else {
                self.view?.OnGetAllSateError()
                print("Error presentre")
                return
            }
            print("SUCCESS PRESENTER")
            self.view?.OnGetAllStateSuccess(response: response)
            
        })
    }

}
