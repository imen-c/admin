//
//  AddProductPresenter.swift
//  admin
//
//  Created by imen cheref on 11/09/2023.
//

import Foundation

class AddProductPresenter{
    
    weak var view : AddProductProtocol?
    
    init(view : AddProductProtocol){
        self.view = view
    }
    
    func addOneProduct(item: Product, catId: Int){
        
        DataManager.instance.addOneProduct(product: item, catId: catId, completion: { response in
            guard response != nil else {
                self.view?.onSendProductError()
                return
            }
            self.view?.onSendProductSuccess()
        })
        
    }
    
}
