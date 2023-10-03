//
//  MessengerController.swift
//  admin
//
//  Created by imen cheref on 14/09/2023.
//

import UIKit

class MessengerController: UIViewController , MessengerProtocol, ReloadTableViewDelegate{


    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!    
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableVIEW: UITableView!
    
    var presenter: MessengerPresenter?
    var messageReceived = [Message]()
    var messageToShow =  [Message]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = MessengerPresenter(view: self)
        self.presenter?.getMessages()
        self.searchBar.delegate = self
        
        self.tableVIEW.dataSource = self
        self.tableVIEW.delegate = self
        self.tableVIEW.register(UINib(nibName: "MessageViewCell", bundle: nil), forCellReuseIdentifier: "MessageViewCell")
        
        
        
      
        self.tableVIEW.reloadData()
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 1
        
        Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(updateTableView), userInfo: nil, repeats: true)

    }
    
    func reload() {
        print("RELOAD")
        self.presenter?.getMessages()
        self.segmentedControl.selectedSegmentIndex = 1
    }
    func OnDeleteError() {
        print("📕 Delete Message")
    }
    
    func OnDeleteSuccess() {
        print("📗 Delete Message")
        self.tableVIEW.reloadData()
        
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
    @objc func updateTableView(){
        self.presenter?.getMessages()
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
            
            self.messageToShow.sort{ !($0.isRead ?? false) && ($1.isRead ?? false)}
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
                messageDetailController.dismissDelegate = self
                navigationController?.pushViewController(messageDetailController, animated: true)
               
            }
            
        }else{
            guard let modal = storyboard?.instantiateViewController(withIdentifier: "ReadOnlyMessageController") as? ReadOnlyMessageController else{return}
            //modal.configure(item: item)
            modal.modalPresentationStyle = .formSheet
            modal.configure(item: item)
            modal.dismissDelegate = self
            self.present(modal,animated: true, completion: nil)
        }
    }
    


}
extension MessengerController: UITableViewDelegate, UITableViewDataSource{

    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if(messageToShow.isEmpty){
          self.emptyLabel.isHidden = false
          self.emptyLabel.text = "Vous n'avez pas de message(s)"
      }else{
          self.emptyLabel.isHidden = true
      }
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
//      if let num = item.subjectNumber{
//          cell.numberLabel.text = String(num)
//      }
      cell.subjectName.text = item.subject
      cell.emailLabel.text = item.user.email
      if let date = item.createdAt{
          cell.configure(date: date)
          
      }
     

          
            return cell
        }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
 
    


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            tableView.beginUpdates()
            let item = messageToShow[indexPath.row]
            self.presenter?.deleteOneMessage(id: item.id!)
            messageToShow.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        }
    }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
 
    
}
extension MessengerController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            
            messageToShow = messageReceived
        } else {
            messageToShow = messageReceived.filter { message in
                let subjectMatch =  message.subject!.lowercased().contains(searchText.lowercased())
                let userMatch = message.user.email!.lowercased().contains(searchText.lowercased())
                
                return subjectMatch || userMatch
            }
           
        }
        self.tableVIEW.reloadData()
    }

}
