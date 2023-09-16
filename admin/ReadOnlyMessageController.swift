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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configure(item: Message){
        self.emailLabel.text = item.user.email
        if let num = item.subjectNumber{
            self.numberSujbjectLabel.text = String(num)
        }
        self.userTextView.text = item.content
        //self.date
        self.adminTextView.text = item.responseContent
      
    }
    @IBAction func dismissModal(_ sender: Any) {
        
        dismissDelegate?.reload()
        self.dismiss(animated: true, completion: nil)
    }
    


}
