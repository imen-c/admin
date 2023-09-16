//
//  UserPresenter.swift
//  admin
//
//  Created by imen cheref on 17/09/2023.
//

import Foundation

class UserPresenter{
    
    
    weak var view : UserProtocol?
    
    init(view : UserProtocol){
        self.view = view
    }
    
    func getAllUsers(){
        
        DataManager.instance.getAllUsers(completion: {
            response in
            guard let response = response else {
                self.view?.OnGetAllUsersError()
                print("Error presentre")
                return
            }
            print("SUCCESS PRESENTER")
            self.view?.OnGetAllUsersSuccess(response: response)
            
        })
    }

}
