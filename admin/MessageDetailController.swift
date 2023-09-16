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
    var response : String?
    
    var first = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.userContent.delegate = self
        self.responseContent.delegate = self
        self.userContent.layer.borderWidth = 1
        self.responseContent.layer.borderWidth = 1
        self.userContent.layer.cornerRadius = 6
        self.responseContent.layer.cornerRadius = 6
        self.responseContent.text = "Votre réponse ici .."
        self.userContent.layer.borderColor = UIColor(named: "CDCDCD")?.cgColor
        self.responseContent.layer.borderColor = UIColor(named: "CDCDCD")?.cgColor
        UITextView.appearance().tintColor = .black
        
        
        self.userLabel.text = item?.user.email
        self.subjectLabel.text = item?.subject
        if let num = item?.subjectNumber{
            self.subLabel.text = String(num)
        }
        self.dateLabel.text = "date"
        self.userContent.text = item?.content
        
        self.presenter = MessengerDetailPresenter(view: self)
        self.presenter?.markIsRead(id: (item?.id)!)
        
       


    }
    override func viewWillDisappear(_ animated: Bool) {
        self.dismissDelegate?.reload()
    }
    
    @IBAction func sendResponse(_ sender: Any) {
        
        if let response = response{
            
            self.presenter?.sendMessageResponse(id: (item?.id)!, message: response)
        }
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
    func OnSendMessageSuccess() {
        print("📗 send message")
        
        let alert = UIAlertController(title: "Succès", message: "Le message a bien été envoyé", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fermer", style: .default, handler: { (action) in
          self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert,animated: true)
    }
    
    func OnSendMessageError() {
        print("📕 send message")
    }


}

extension MessageDetailController: UITextViewDelegate{
  
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (first){
            textView.text = ""
            first = false
            
        }
       
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.response = textView.text
    }
}
