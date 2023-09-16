//
//  MessengerPresenter.swift
//  admin
//
//  Created by imen cheref on 15/09/2023.
//

import Foundation

class MessengerPresenter{
    
    
    weak var view : MessengerProtocol?
    
    init(view : MessengerProtocol){
        self.view = view
    }
    
    func getMessages(){
        
        DataManager.instance.getAllMessages(completion: {
            response in
            guard let response = response else {
                self.view?.OnGetAllMessageError()
                print("Error presentre")
                return
            }
            print("SUCCESS PRESENTER")
            self.view?.OnGetAllMessageSuccess(response: response)
            
        })
    }
    func deleteOneMessage(id: Int){
        DataManager.instance.deleteOneMessage( id: id,  completion: {
            response in
            guard let response = response else {
                self.view?.OnDeleteError()
                print("Error presentre")
                return
            }
            print("SUCCESS PRESENTER", response)
            self.view?.OnDeleteSuccess()
            
        })
        
    }

}
