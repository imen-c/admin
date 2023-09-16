//
//  MessengerController.swift
//  admin
//
//  Created by imen cheref on 14/09/2023.
//

import UIKit

class MessengerController: UIViewController , MessengerProtocol, ReloadTableViewDelegate{
    func reload() {
        self.presenter?.getMessages()
    }
    

    

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!    
   
    @IBOutlet weak var tableVIEW: UITableView!
    
    var presenter: MessengerPresenter?
    var messageReceived = [Message]()
    var messageToShow =  [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = MessengerPresenter(view: self)
        self.presenter?.getMessages()
        // Do any additional setup after loading the view.
        guard let messageDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MessageDetailController") as? MessageDetailController else {return}
                messageDetailVC.dismissDelegate = self
        self.tableVIEW.dataSource = self
        self.tableVIEW.delegate = self
        self.tableVIEW.register(UINib(nibName: "MessageViewCell", bundle: nil), forCellReuseIdentifier: "MessageViewCell")
        
        self.tableVIEW.reloadData()
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 1
    }
    


    func OnGetAllMessageSuccess(response: [Message]) {
        print("📗 get All Message")
        print(response)
        self.messageReceived = response
        print(messageReceived.count)
        self.messageToShow = self.messageReceived
        self.tableVIEW.reloadData()
  
    }

    
    func OnGetAllMessageError() {

        print("📕 get All Message")
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl){
        
        let selectedIndex = sender.selectedSegmentIndex
        
        switch selectedIndex {
        case 0:
            print("non lus")
            self.messageToShow = messageReceived.filter{$0.isRead == false}
            self.tableVIEW.reloadData()
            
        case 1:
            
            print("all")
            self.messageToShow = messageReceived
            self.tableVIEW.reloadData()
        case 2:
           
            print("en attente de rep")
            
            self.messageToShow = messageReceived.filter{$0.response == false}
            self.tableVIEW.reloadData()
        default:
            break
        }

    }
    func manageOpenDetail(isComplete: Bool, item: Message){
        
        if(!isComplete){
            if let messageDetailController = storyboard?.instantiateViewController(withIdentifier: "MessageDetailController") as? MessageDetailController{
                messageDetailController.configure(item: item)
                navigationController?.pushViewController(messageDetailController, animated: true)
               
            }
            
        }else{
            guard let modal = storyboard?.instantiateViewController(withIdentifier: "ReadOnlyMessageController") as? ReadOnlyMessageController else{return}
            //modal.configure(item: item)
            modal.modalPresentationStyle = .formSheet
            self.present(modal,animated: true, completion: nil)
        }
    }
    


}
extension MessengerController: UITableViewDelegate, UITableViewDataSource{

    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messageToShow.count
         
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = messageToShow[indexPath.row]
            print(item.id)
            if let isResponse = item.response{
                manageOpenDetail(isComplete: isResponse, item: item)
            }
            
        

        
    }
        
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageViewCell", for: indexPath) as! MessageViewCell
            let item = messageToShow[indexPath.row]
      if let num = item.subjectNumber{
          cell.numberLabel.text = String(num)
      }
            
            return cell
        }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    
}
