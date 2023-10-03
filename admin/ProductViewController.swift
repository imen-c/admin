//
//  ProductViewController.swift
//  admin
//
//  Created by imen cheref on 04/09/2023.
//

import UIKit

class ProductViewController: UIViewController, ReloadTableViewDelegate {

    

   
    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var addProductButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var productList = [Product]()
    var filteredList = [Product]()
    var categories = [Category]()
    var presenter : ProductViewPresenter?
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ProductViewPresenter(view: self)
        self.presenter?.getProducts()
        self.presenter?.getAllCategories()
        
        self.searchBar.delegate = self
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        self.tableView.reloadData()

  
    }
    
    
    @IBAction func addProduct(_ sender: Any) {
        
        if let addProductVC = storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as? AddProductViewController{
            addProductVC.dismissDelegate = self
            addProductVC.configure(categories: categories)
            navigationController?.pushViewController(addProductVC, animated: true)
            print("GO ADD")
        }
        
    }

    func reload() {
        print("RELOAD")
        self.presenter?.getProducts()
    }
    
    

}
extension ProductViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
               // Réinitialisez filteredList pour afficher tous les produits
               filteredList = productList
           } else {
               filteredList = productList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
           }
        self.tableView.reloadData()
    }
}
extension ProductViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        cell.contentView.frame.size.width = tableView.bounds.size.width


        cell.name.text = filteredList[indexPath.row].name
        cell.quantity.text = String(filteredList[indexPath.row].quantity)
        
        if let price = filteredList[indexPath.row].price{
            cell.price.text = String(price)
            
        }
     
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
 
    


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            let item = filteredList[indexPath.row]
            self.presenter?.deleteOneProduct(id: item.id!)
            filteredList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.endUpdates()
            
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = filteredList[indexPath.row]
        
        let btnModify = UIContextualAction(style: .normal, title: "Mofifier"){(action,view,completion) in
            self.presentModal(item: item)
            
            
            completion(true)
            
        }
        let btnDelete = UIContextualAction(style: .normal, title: "Supprimer"){(action,view,completion) in
            
            let alert = UIAlertController(title: "Attention", message: "Êtes-vous sûr de vouloir supprimer ce contenu ? ", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Oui", style: .destructive, handler: { alert in
                self.presenter?.deleteOneProduct(id: item.id!)
                self.filteredList.remove(at: indexPath.row)
            }))
            self.present(alert, animated: true, completion: nil)
            
            completion(true)
            
        }
        btnDelete.backgroundColor = .red
        let config = UISwipeActionsConfiguration(actions: [btnModify,btnDelete])
        
        return config
    }
    
    func presentModal(item : Product){
        guard let modal = storyboard?.instantiateViewController(withIdentifier: "ModalEditProduct") as? ModalEditProduct else{return}
        modal.configure(item: item)
        modal.modalPresentationStyle = .currentContext
        self.present(modal,animated: true, completion: nil)
                
    }
    
    
    
    
}
extension ProductViewController : ProductViewProtocol{
    func OnGetCategoriesSuccess(response: [Category]) {
        print("📗 Get category")
        self.categories = response
    }
    
    func OnGetCategoriesError() {
        print("📕 Get category")
    }
    
    func OnDeleteOneProductSuccess(response: MessageJson) {
        print("📗 Delete product")
        
        self.tableView.reloadData()
    }
    
    func onDeleteOneProductError() {
        print("📕 Delete Products")
    }
    
    func OnGetProductSuccess(response: [Product]) {
        print("📗 Get Products")
        self.productList = response
        self.filteredList = productList
        
        self.tableView.reloadData()
    }
    
    func OnGetProductError() {
         print("📕 Get Products")
    }
    
    
    
}
