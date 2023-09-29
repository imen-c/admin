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
    
    func deleteOneProduct(id:Int){
        DataManager.instance.deleteOneProduct(id: id, completion: {
            response in
            guard let response = response else {
                self.view?.onDeleteOneProductError()
                print("Error Delete Product presenter")
                return
            }
            print("SUCCESS delete product presenter")
            self.view?.OnDeleteOneProductSuccess(response: response)
        })
        
    }
    func getAllCategories(){
        
        DataManager.instance.getAllCategories(completion: {
            response in
            guard let response = response else {
                self.view?.OnGetCategoriesError()
                print("Error presentre")
                return
            }
            print("SUCCESS PRESENTER")
            self.view?.OnGetCategoriesSuccess(response: response)
            
        })
    }
}
