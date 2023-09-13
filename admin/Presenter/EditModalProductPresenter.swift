//
//  EditModalProductPresenter.swift
//  admin
//
//  Created by imen cheref on 13/09/2023.
//

import Foundation


class EditModalProductPresenter{
    
    weak var view : EditModalProductProtocol?
    
    init(view : EditModalProductProtocol){
        self.view = view
    }
    
    func editProduct(item: Product, catId: Int){
        
        DataManager.instance.editProduct(product: item, catId: catId, completion: { response in
            guard response != nil else {
                self.view?.onEditProductError()
                return
            }
            self.view?.onEditProductSuccess()
        })
        
    }
    
}
