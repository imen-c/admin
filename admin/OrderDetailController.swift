//
//  OrderDetailController.swift
//  admin
//
//  Created by imen cheref on 25/09/2023.
//

import UIKit

class OrderDetailController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var addresslineLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var order = Order()
    var stateOrderList = [StateOrder]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "OrderDetailCell", bundle: nil), forCellReuseIdentifier: "OrderDetailCell")
        
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.emailLabel.text = order.customer.email
        self.lastnameLabel.text = order.customer.lastname
        self.firstnameLabel.text = order.customer.firstname
        self.phoneLabel.text = order.customer.phone
        
        self.addresslineLabel.text = order.address.addressLine
        self.countryLabel.text = order.address.country
        self.postalCodeLabel.text = order.address.postalCode
        self.cityLabel.text = order.address.city
        

        // Do any additional setup after loading the view.
    }
    
    func configure(item: Order, stateOrderList: [StateOrder]){
        self.order = item
        self.stateOrderList = stateOrderList
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension OrderDetailController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.orderLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailCell", for: indexPath) as! OrderDetailCell
        cell.configure(line: order.orderLines[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    
    
    
    
}
extension OrderDetailController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.stateOrderList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateOrderList[row].name  // Remplacez dataArray par votre tableau de données
    }
    
    
    
    
}
