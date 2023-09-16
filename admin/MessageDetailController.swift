//
//  MessageDetailController.swift
//  admin
//
//  Created by imen cheref on 15/09/2023.
//

import UIKit

class MessageDetailController: UIViewController, MessengerDetailProtocol {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var userContent: UITextView!
    @IBOutlet weak var responseContent: UITextView!
    
    
    weak var dismissDelegate: ReloadTableViewDelegate?
    var presenter: MessengerDetailPresenter?
    var item : Message?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = MessengerDetailPresenter(view: self)
        self.presenter?.markIsRead(id: (item?.id)!)
        
       


    }
    
    @IBAction func sendResponse(_ sender: Any) {
    }
    

    func configure(item:  Message){
        self.item = item
        
        self.presenter?.markIsRead(id: (item.id)!)
        
    
    }
    
    func OnMarkIsReadSuccess() {
        print("📗 Mark is Read")
        dismissDelegate?.reload()
        
    }
    
    func OnMarkIsReadError() {
        print("📕 Mark is Read")
    }

}
