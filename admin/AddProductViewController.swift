//
//  AddProductViewController.swift
//  admin
//
//  Created by imen cheref on 05/09/2023.
//

import UIKit

class AddProductViewController: UIViewController, AddProductProtocol {



    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var editDescription: UITextView!
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var editPrice: UITextField!
    @IBOutlet weak var quantityTitle: UILabel!
    @IBOutlet weak var editQuantity: UITextField!
    
    @IBOutlet weak var sizeSTitle: UILabel!
    @IBOutlet weak var editS: UITextField!
    @IBOutlet weak var sizeMTitle: UILabel!
    @IBOutlet weak var editM: UITextField!
    @IBOutlet weak var sizeLTitle: UILabel!
    @IBOutlet weak var editL: UITextField!
    @IBOutlet weak var sizeXLTitle: UILabel!
    @IBOutlet weak var editXL: UITextField!
    @IBOutlet weak var sizeXXLTitle: UILabel!
    @IBOutlet weak var editXXL: UITextField!
    
    @IBOutlet weak var imageNameTitle: UILabel!
    @IBOutlet weak var editImageName: UITextField!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var addCategoryButton: UIButton!
    @IBOutlet weak var imageInputView: InputImageView!
    @IBOutlet weak var confirmButton: UIButton!
    
    //MARK: varibales
    var presenter : AddProductPresenter?
    weak var dismissDelegate: ReloadTableViewDelegate?
    
    var categoriesReceived = [Category]()
    
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
        super.viewDidLoad()
        
        self.presenter = AddProductPresenter(view: self)
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        self.imageInputView.configure { (image) in
            self.image = image
           // self.validReport()
        }
        self.editName.delegate = self
        self.editPrice.delegate = self
        self.editQuantity.delegate = self
        self.editS.delegate = self
        self.editM.delegate = self
        self.editL.delegate = self
        self.editXL.delegate = self
        self.editXXL.delegate = self
        self.editDescription.delegate = self
        self.editImageName.delegate = self

        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    func configure(categories : [Category]){
        self.categoriesReceived = categories
    }
    

    @IBAction func onSendProduct(_ sender: Any) {
        let product = Product()
        if let image = self.image{
            let imageData: Data = image.jpegData(compressionQuality: 80)!
            let strBase64 = imageData.base64EncodedString()
            let prefix = String(strBase64.prefix(1000))
            print(prefix)
            product.imageUrl = strBase64
            
            
                }
                product.name = self.name ?? ""
                product.quantity = self.quantity
                product.price = (self.price)
                product.sizeS = self.S
                product.sizeM = self.M
                product.sizeL = self.L
                product.sizeXL = self.XL
                product.sizeXXL = self.XXL
                product.description = self.descriptionV
                product.imageName = self.imageName
        
        presenter?.addOneProduct(item: product, catId: 52)


    }
    
    func onSendProductSuccess() {
        print("  📗 Add Product")
        let alert = UIAlertController(title: "Ajout d'un produit", message: "Le produit a bien été ajouté et le statut est actif.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fermer", style: .default, handler: { (action) in
            
            self.dismissDelegate?.reload()
            self.navigationController?.popViewController(animated: true)
            
        }))
        self.present(alert,animated: true)
    }
    
    func onSendProductError() {
        print("  📕 Add Product")
    }
    
    

}
extension AddProductViewController: UITextFieldDelegate,UITextViewDelegate{
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

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == self.editName{
            guard let name = textField.text else{return}
            print(name)
            self.name = name

        } else if textField == self.editPrice{
            guard let price = textField.text else{return}
            self.price = Float(price) ?? 0.00

        } else if textField == self.editQuantity{
            guard let quantity = textField.text else{return}
            self.quantity = Int(quantity) ?? 0
            print("quantity reçu")
            print(self.quantity)
        } else if textField == self.editS{
            guard let S = textField.text else{return}
            self.S = Int(S) ?? 0
            
        }else if textField == self.editM{
            guard let M = textField.text else{return}
            self.M = Int(M) ?? 0
        }else if textField == self.editL{
            guard let L = textField.text else{return}
            self.L = Int(L) ?? 0
            
        }else if textField == self.editXL{
            guard let XL = textField.text else{return}
            self.XL = Int(XL) ?? 0
        }else if textField == self.editXXL{
            guard let XXL = textField.text else{return}
            self.XXL = Int(XXL) ?? 0
        }else if textField == self.editImageName{
            guard let iname = textField.text else{return}
            self.imageName = iname
        }
       //self.validReport()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Votre description..."{
            textView.text = ""
            textView.textColor = .darkText
        }
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
                self.descriptionV = textView.text
            }
            //self.validReport()
        }

    
    
    
}

extension AddProductViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesReceived.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesReceived[row].name
       }
    
    
}
