//
//  LoginController.swift
//  admin
//
//  Created by imen cheref on 03/10/2023.
//

import UIKit

class LoginController: UIViewController {
    
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var editLogin: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var editPassword: UITextField!
    @IBOutlet weak var connectButton: UIButton!
    
    var presenter: LoginPresenter?
    var login = ""
    var password = ""
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = LoginPresenter(view: self)
        // Do any additional setup after loading the view.
        
        self.editLogin.delegate = self
        self.editPassword.delegate = self
    }

    
    @IBAction func connect(_ sender: Any) {
        
        self.presenter?.connectAdmin(login: login, password: password)
    }
    

}
extension LoginController : LoginProtocol{
    func OnConnexionSuccess(response: LoginResponse) {
        print("📗 Connexion")
        print("connexion status")
        print((response.token) as Any)
        print("token")
        
        if (response.token == nil){
            let alert = UIAlertController(title: "Connexion", message: "Problème dans vos credentials.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Fermer", style: .default, handler: { (action) in
                
                self.navigationController?.popViewController(animated: true)
                
            }))
            self.present(alert,animated: true)
        }else{
            if let dashController = storyboard?.instantiateViewController(withIdentifier: "DashboardController") as?
                ViewController{
                
                navigationController?.pushViewController(dashController, animated: true)
                print("GO Connect")
            }

        }
    }
    
    func OnConnexionError() {
        print("📕 Connexion")
        let alert = UIAlertController(title: "Connexion", message: "Une erreur est survenue.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fermer", style: .default, handler: { (action) in
            
            self.navigationController?.popViewController(animated: true)
            
        }))
        self.present(alert,animated: true)
    }
 
    
}
    extension LoginController : UITextFieldDelegate{
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            if textField == self.editLogin{
                guard let log = textField.text else{return}
                //self.name = name
                self.login = log
            }else if textField == self.editPassword{
                guard let pw = textField.text else{return}
                //self.name = name
                self.password = pw
            }
        }
    }
