//
//  OrdersController.swift
//  admin
//
//  Created by imen cheref on 16/09/2023.
//

import UIKit

class OrdersController: UIViewController, OrdersProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var resumeView: UIView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalOrderLabel: UILabel!
    @IBOutlet weak var totalOrderGeneric: UILabel!
    
    @IBOutlet weak var monthlyIncome: UILabel!
    @IBOutlet weak var monthlyIncomeGeneric: UILabel!
    
    
    var presenter: OrdersPresenter?
    var orders = [Order]()
    var ordersToShow = [Order]()
    var stateOrderList = [StateOrder]()
    
    var totalOrder = 0.00
    var pieces = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = OrdersPresenter(view: self)
        self.presenter?.getAllOrders()
        self.presenter?.getAllStateOrder()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
        
        self.totalOrderGeneric.text = "nouvelle(s) commande(s) \n           aujourd'hui"
        self.monthlyIncomeGeneric.text = "chiffre d'affaire \n        du mois"
        
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        // Do any additional setup after loading the view.
        self.tableView.reloadData()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl){
        
        
        
        let selectedIndex = sender.selectedSegmentIndex
        
        switch selectedIndex {
        case 0:
            print("à confirmer")
            
            self.ordersToShow = orders.filter{$0.status.name == "new"}
            
            self.tableView.reloadData()
            
        case 1:
            
            print("à envoyer")
            self.ordersToShow = orders.filter{$0.status.name == "confirmed"}
           // self.messageToShow = messageReceived
            
            //self.messageToShow.sort{ !($0.isRead ?? false) && ($1.isRead ?? false)}
            self.tableView.reloadData()
            
        case 2:
           
            print("en cheminement")
            
            self.ordersToShow = orders.filter{$0.status.name == "send"}
            self.tableView.reloadData()
        default:
            break
        }

    }
    
    func OnGetAllOrdersSuccess(response: OrderData) {
        print("📗 Get Orders")
        self.orders = response.orders
        self.ordersToShow = orders
        if let tot = response.totalOrdersToday{
            self.totalOrderLabel.text = String(tot)
            
        }
        if let mi = response.monthIncome{
            self.monthlyIncome.text = "\(mi) €"
        }
        print("COUNT SUCCESS")
        print(orders.count)
        print(ordersToShow.count)
        //print(response.monthIncome)
        self.tableView.reloadData()
    }
    
    func OnGetAllOrdersError() {
        print("📕 Get Orders")
    }
    func OnGetAllStateSuccess(response: [StateOrder]) {
        print("📗 Get StateOrder")
        self.stateOrderList = response
    }
    
    func OnGetAllSateError() {
        print("📕 Get StateOrder")
    }



}
extension OrdersController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("COUNT")
        print(ordersToShow.count)
        return ordersToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        //cell.email.text = ordersToShow[indexPath.row].customer.email
        
        for orderLine in ordersToShow[indexPath.row].orderLines{
            var totalOrderRounded = 0.00
            if let subTotal = orderLine.subTotal{
                 totalOrderRounded += Double(subTotal) ?? 0.00
                totalOrder = (totalOrderRounded * 100).rounded() / 100
                
            }
            if let quantity = orderLine.qty{
                pieces += Int(quantity)
            }
            
            
        }
       
        cell.itemNumber.text =  "\(pieces) articles(s)"
        cell.total.text = "\(totalOrder) €"
        cell.configure(item: ordersToShow[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = ordersToShow[indexPath.row]
        if let orderDetailController = storyboard?.instantiateViewController(withIdentifier: "OrderDetailController") as? OrderDetailController{
            orderDetailController.configure(item: item, stateOrderList: stateOrderList)
            //orderDetailController.dismissDelegate = self
            navigationController?.pushViewController(orderDetailController, animated: true)
           
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
