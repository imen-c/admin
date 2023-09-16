//
//  ReadOnlyMessageController.swift
//  admin
//
//  Created by imen cheref on 15/09/2023.
//

import UIKit

protocol ReloadTableViewDelegate: NSObjectProtocol{
    func reload()
}

class ReadOnlyMessageController: UIViewController {
    
    
    @IBOutlet weak var userTitle: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numberSujbjectLabel: UILabel!
    
    @IBOutlet weak var userTextView: UITextView!
    
    @IBOutlet weak var responseTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var adminTextView: UITextView!
    
    @IBOutlet weak var checkButton: UIButton!
    
    weak var dismissDelegate: ReloadTableViewDelegate?
    var message : Message?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTextView.delegate = self
        self.adminTextView.delegate = self
//        guard let messageVC = self.storyboard?.instantiateViewController(withIdentifier: "MessengerController") as? MessengerController else {return}
//                self.dismissDelegate = messageVC
        if let mess = message{
            self.emailLabel.text = mess.user.email
            if let num = mess.subjectNumber{
                self.numberSujbjectLabel.text = "numéro:" + String(num)
            }
            self.userTextView.text = mess.content
            self.adminTextView.text = mess.responseContent
            
        }


    }
    
    func configure(item: Message){
        self.message = item
      
      
    }
    @IBAction func dismissModal(_ sender: Any) {
        
        dismissDelegate?.reload()
        self.dismiss(animated: true, completion: nil)
    }
    


}
extension ReadOnlyMessageController: UITextViewDelegate{
    
    
}
