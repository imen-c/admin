//
//  ProductViewPresenter.swift
//  admin
//
//  Created by imen cheref on 08/09/2023.
//

import Foundation


class ProductViewPresenter{
    
    
    weak var view : ProductViewProtocol?
    
    init(view : ProductViewProtocol){
        self.view = view
    }
    
    func getProducts(){
        print("je passe dans presenter")
        DataManager.instance.getProducts(completion: {
            response in
            guard let response = response else {
                self.view?.OnGetProductError()
                print("Error presentre")
                return
            }
            print("SUCCESS PRESENTER")
            self.view?.OnGetProductSuccess(response: response)
            
        })
    }
}
