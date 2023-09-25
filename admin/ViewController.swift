//
//  ViewController.swift
//  admin
//
//  Created by imen cheref on 04/09/2023.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var bodyMenu: UIView!
    @IBOutlet weak var stackButtonMenu: UIStackView!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    @IBOutlet weak var leftSquareButton: UIButton!
    @IBOutlet weak var rightSquareButton: UIButton!
    
    @IBOutlet weak var BigButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.firstButton.setTitle("Produits", for: .normal)

    }

    @IBAction func navigateToProduct(_ sender: Any) {
        
        if let productController = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController{
            
            navigationController?.pushViewController(productController, animated: true)
            print("GO PRODUCT")
        }
    }
    
    @IBAction func navigateToMessage(_ sender: Any) {
        if let messageController = storyboard?.instantiateViewController(withIdentifier: "MessengerController") as? MessengerController{
            
            navigationController?.pushViewController(messageController, animated: true)
            print("GO MESSAGE")
        }
        
    }
    
    
    @IBAction func navigateToUser(_ sender: Any) {
        
        
        if let userController = storyboard?.instantiateViewController(withIdentifier: "UserController") as? UserController{
            
            navigationController?.pushViewController(userController, animated: true)
            print("GO User")
        }
    }
    
    @IBAction func navigateToOrders(_ sender: Any) {
        
        
        if let ordersController = storyboard?.instantiateViewController(withIdentifier: "OrdersController") as? OrdersController{
            
            navigationController?.pushViewController(ordersController, animated: true)
            print("GO Orders")
        }
    }
    
    
    @IBAction func navigateToDiffusion(_ sender: Any) {
        
        if let diffusionController = storyboard?.instantiateViewController(withIdentifier: "DiffusionController") as? DiffusionController{
            
            navigationController?.pushViewController(diffusionController, animated: true)
            print("GO Diffusion")
        }
    }
    
    

}

