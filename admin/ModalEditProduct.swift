//
//  ModalEditProduct.swift
//  admin
//
//  Created by imen cheref on 10/09/2023.
//

import Foundation
import UIKit



class ModalEditProduct: UIViewController, UITextFieldDelegate, UITextViewDelegate, EditModalProductProtocol{
    
    
    
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var editDescription: UITextView!
    
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var editPrice: UITextField!
    @IBOutlet weak var quantityTitle: UILabel!
    @IBOutlet weak var editQuantity: UITextField!
    @IBOutlet weak var sizeSTitle: UILabel!
    @IBOutlet weak var sizeMTitle: UILabel!
    @IBOutlet weak var sizeLTitle: UILabel!
    @IBOutlet weak var sizeXLTitle: UILabel!
    @IBOutlet weak var sizeXXLTitle: UILabel!
    @IBOutlet weak var editS: UITextField!
    @IBOutlet weak var editM: UITextField!
    @IBOutlet weak var editL: UITextField!
    @IBOutlet weak var editXL: UITextField!
    @IBOutlet weak var editXXL: UITextField!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var isActiveLabel: UILabel!
    @IBOutlet weak var isActiveButton: UISwitch!
    
    @IBOutlet weak var imageNameTitle: UILabel!
    @IBOutlet weak var editImageName: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var changeImageButton: UISwitch!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var InputImageView: InputImageView!
    
    var wantChangeImage = false
    
    var productToEdit = Product()
    //MARK: varibales
    var presenter : EditModalProductPresenter?
    
    var activeField: UIView?
    var name: String?
    var descriptionV: String?
    var price:Float  = 0.00
    var quantity  = 0
    var S = 0
    var M = 0
    var L = 0
    var XL = 0
    var XXL = 0
    var category: Category?
    var image: UIImage?
    var imageName: String?
    
    
    
    override func viewDidLoad() {
        
        self.presenter = EditModalProductPresenter(view: self)
        self.InputImageView.configure { (image) in
            self.image = image
           // self.validReport()
        }
        
        isActiveButton.addTarget(self, action: #selector(isActiveSwitchChange(_:)), for: .allTouchEvents)
        changeImageButton.addTarget(self, action: #selector(changeImageSwitchChange(_:)), for: .allTouchEvents)
        
        UITextField.appearance().tintColor = .black
        self.editName.text = productToEdit.name
        self.editDescription.text = productToEdit.description
        if let price = productToEdit.price{
            self.editPrice.text = String(price)
        }
        //self.editPrice.text = String(productToEdit.price)
        self.editQuantity.text = String(productToEdit.quantity)
        self.editS.text = String(productToEdit.sizeS)
        self.editM.text = String(productToEdit.sizeM)
        self.editL.text = String(productToEdit.sizeL)
        self.editXL.text = String(productToEdit.sizeXL)
        self.editXXL.text = String(productToEdit.sizeXXL)
        
        self.editName.delegate = self
        self.editDescription.delegate = self
        self.editPrice.delegate = self
        self.editQuantity.delegate = self
        self.editS.delegate = self
        self.editM.delegate = self
        self.editL.delegate = self
        self.editXL.delegate = self
        self.editXXL.delegate = self
        self.editImageName.delegate = self
        
        if let isActive = productToEdit.isActive{
            
            self.isActiveButton.isOn = isActive
            
        }
        
    }
    
    func configure( item: Product){
        productToEdit = item
        
    }
    
    @IBAction func cancelEdit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmEdit(_ sender: Any) {
        productToEdit.image64 = "none"
        // savoir si on doit changer l image !!!
        if (wantChangeImage == true){
            if let image = self.image{
                let imageData: Data = image.jpegData(compressionQuality: 80)!
                let strBase64 = imageData.base64EncodedString()
                let prefix = String(strBase64.prefix(1000))
                print(prefix)
                productToEdit.image64 = strBase64
                
            }
        }
              

            
            presenter?.editProduct(item: productToEdit, catId: 37)
            
            
            
        }
        
       @objc func isActiveSwitchChange(_ sender: Any) {
            if self.isActiveButton.isOn{
                productToEdit.isActive = true
            }else{
                productToEdit.isActive = false
            }

        }
       @objc func changeImageSwitchChange(_ sender: Any) {
            if self.changeImageButton.isOn{
                self.wantChangeImage = true
                print("CHANGE SWITCH IMAGE")
                print(wantChangeImage)
            }else{
                self.wantChangeImage = false
            }
            
            
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.activeField = textField
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            self.activeField = nil
            return true
        }
        func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
            self.activeField = textView
            return true
        }
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
        
//        func textFieldDidEndEditing(_ textField: UITextField) {
//            if textField == self.editName{
//                guard let name = textField.text else{return}
//                //self.name = name
//                productToEdit.name = name
//
//            } else if textField == self.editPrice{
//                guard let price = textField.text else{return}
//                // self.price = Float(price) ?? 0.00
//                productToEdit.price = Float(price)
//
//            } else if textField == self.editQuantity{
//                guard let quantity = textField.text else{return}
//                // self.quantity = Int(quantity) ?? 0
//                productToEdit.quantity = Int(quantity) ?? 0
//
//            } else if textField == self.editS{
//                guard let S = textField.text else{return}
//                //self.S = Int(S) ?? 0
//                productToEdit.sizeS = Int(S) ?? 0
//            }else if textField == self.editM{
//                guard let M = textField.text else{return}
//                //self.M = Int(M) ?? 0
//                productToEdit.sizeM = Int(M) ?? 0
//            }else if textField == self.editL{
//                guard let L = textField.text else{return}
//                //self.L = Int(L) ?? 0
//                productToEdit.sizeL = Int(L) ?? 0
//
//            }else if textField == self.editXL{
//                guard let XL = textField.text else{return}
//                //self.XL = Int(XL) ?? 0
//                productToEdit.sizeXL = Int(XL) ?? 0
//            }else if textField == self.editXXL{
//                guard let XXL = textField.text else{return}
//                //self.XXL = Int(XXL) ?? 0
//                productToEdit.sizeXXL = Int(XXL) ?? 0
//                print("textField XXL")
//                print((XXL))
//            }
//            //        }else if textField == self.editImageName{
//            //            guard let iname = textField.text else{return}
//            //            self.imageName = iname
//            //        }
//            //self.validReport()
//        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == "Décrivez ici le produit..."{
                textView.text = ""
                textView.textColor = .darkText
            }
        }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == self.editName{
            guard let name = textField.text else{return}
            //self.name = name
            productToEdit.name = name
            
        } else if textField == self.editPrice{
            guard let price = textField.text else{return}
            // self.price = Float(price) ?? 0.00
            productToEdit.price = Float(price)
            
        } else if textField == self.editQuantity{
            guard let quantity = textField.text else{return}
            // self.quantity = Int(quantity) ?? 0
            productToEdit.quantity = Int(quantity) ?? 0
            
        } else if textField == self.editS{
            guard let S = textField.text else{return}
            //self.S = Int(S) ?? 0
            productToEdit.sizeS = Int(S) ?? 0
        }else if textField == self.editM{
            guard let M = textField.text else{return}
            //self.M = Int(M) ?? 0
            productToEdit.sizeM = Int(M) ?? 0
        }else if textField == self.editL{
            guard let L = textField.text else{return}
            //self.L = Int(L) ?? 0
            productToEdit.sizeL = Int(L) ?? 0
            
        }else if textField == self.editXL{
            guard let XL = textField.text else{return}
            //self.XL = Int(XL) ?? 0
            productToEdit.sizeXL = Int(XL) ?? 0
        }else if textField == self.editXXL{
            guard let XXL = textField.text else{return}
            //self.XXL = Int(XXL) ?? 0
            productToEdit.sizeXXL = Int(XXL) ?? 0
            print("textField XXL")
            print((XXL))
        }else if textField == self.editImageName{
            guard let imageName = textField.text else{return}
            
            productToEdit.imageName = imageName
        }
      
        //self.validReport()
    }
        func textViewDidChange(_ textView: UITextView) {
            
            self.descriptionV = textView.text
            print("TextView text")
            print(descriptionV!)
            if textView.text == ""{
                textView.text = "Décrivez ici le produit..."
                //textView.textColor = UIColor(hexString: "CDCDCD")
                //self.reportDescription = nil
                // self.descriptionTextView.layer.borderColor = Style.Color.red.cgColor
            } else {
                //self.descriptionV = textView.text
                //self.descriptionTextView.layer.borderColor = UIColor(named: "CDCDCD")?.cgColor
                productToEdit.description = textView.text
            }
            //self.validReport()
        }
        
        
        func onEditProductSuccess() {
            print("  📗 Edit Product")
            let alert = UIAlertController(title: "Modification d'un produit", message: "Le produit a bien été modifié.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Fermer", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert,animated: true)
        }
        
        func onEditProductError() {
            print("  📕 Edit Product")
        }
        
        
        
        
        
    }

