//
//  LoginPresenter.swift
//  admin
//
//  Created by imen cheref on 03/10/2023.
//

import Foundation

class LoginPresenter{
    
    
    weak var view : LoginProtocol?
    
    init(view : LoginProtocol){
        self.view = view
    }
    
    func connectAdmin(login: String, password: String){
        
        DataManager.instance.connectAdmin(login: login, password: password, completion: {
            response in
            guard let response = response else {
                self.view?.OnConnexionError()
                print("Error presentre")
                return
            }
            print("SUCCESS PRESENTER")
            self.view?.OnConnexionSuccess(response: response)
            
        })
    }

}
