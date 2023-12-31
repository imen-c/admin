//
//  MessengerDetailPresenter.swift
//  admin
//
//  Created by imen cheref on 16/09/2023.
//

import Foundation

class MessengerDetailPresenter{
    
    
    weak var view : MessengerDetailProtocol?
    
    init(view : MessengerDetailProtocol){
        self.view = view
    }
    
    func markIsRead(id: Int){
        DataManager.instance.markIsRead( id: id, completion: {
            response in
            guard let response = response else {
                self.view?.OnMarkIsReadError()
                print("Error presentre")
                return
            }
            print("SUCCESS PRESENTER", response)
            self.view?.OnMarkIsReadSuccess()
            
        })
        
    }
    
    func sendMessageResponse(id: Int, message: String){
        DataManager.instance.sendMessageResponse( id: id, message: message,  completion: {
            response in
            guard let response = response else {
                self.view?.OnSendMessageError()
                print("Error presentre")
                return
            }
            print("SUCCESS PRESENTER", response)
            self.view?.OnSendMessageSuccess()
            
        })
        
    }


    
}
