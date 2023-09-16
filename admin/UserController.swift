//
//  UserController.swift
//  admin
//
//  Created by imen cheref on 16/09/2023.
//

import UIKit

class UserController: UIViewController, UserProtocol {

    

    

    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var userList = [User]()
    var userToShow = [User]()
    
   var presenter : UserPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = UserPresenter(view: self)
        self.presenter?.getAllUsers()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")

        // Do any additional setup after loading the view.
    }

    func OnGetAllUsersSuccess(response: [User]) {
        print("📗 get All Users")
        self.userList = response
        self.tableView.reloadData()
    }
    
    func OnGetAllUsersError() {


        print("📕 get All Users")
    }



}
extension UserController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        let item = userList[indexPath.row]
        cell.emailLabel.text = item.email
        cell.lastNameLabel.text = item.name
        if let ord = item.ordersCount{
            cell.ordersCount.text = String(ord)        }
        if let mess = item.messageCount{
            cell.messageCount.text = String(mess)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
