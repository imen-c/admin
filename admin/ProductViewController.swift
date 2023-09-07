//
//  ProductViewController.swift
//  admin
//
//  Created by imen cheref on 04/09/2023.
//

import UIKit

class ProductViewController: UIViewController {

   
    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var addProductButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var productList = [Product]()
    var presenter : ProductViewPresenter?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ProductViewPresenter(view: self)
        self.presenter?.getProducts()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        self.tableView.reloadData()

  
    }
    
    @IBAction func addProduct(_ sender: Any) {
        
        if let addProductVC = storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as? AddProductViewController{
            
            navigationController?.pushViewController(addProductVC, animated: true)
            print("GO ADD")
        }
        
    }
    
    

}
extension ProductViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(productList.count, "COUNT COUNT")
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        cell.contentView.frame.size.width = tableView.bounds.size.width


        cell.name.text = productList[indexPath.row].name
        cell.quantity.text = String(productList[indexPath.row].quantity)
        cell.sizeS.text = String(productList[indexPath.row].sizeS)
        cell.sizeM.text = String(productList[indexPath.row].sizeM)
        cell.sizeL.text = String(productList[indexPath.row].sizeL)
        cell.sizeXL.text = String(productList[indexPath.row].sizeXL)
        cell.sizeXXL.text = String(productList[indexPath.row].sizeXXL)
        cell.price.text = productList[indexPath.row].price
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
    
}
extension ProductViewController : ProductViewProtocol{
    func OnGetProductSuccess(response: [Product]) {
        print("📗 Get Products")
        self.productList = response
        self.tableView.reloadData()
    }
    
    func OnGetProductError() {
         print("📕 Get Products")
    }
    
    
    
}
