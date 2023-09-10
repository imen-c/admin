//
//  ModalEditProduct.swift
//  admin
//
//  Created by imen cheref on 10/09/2023.
//

import Foundation
import UIKit



class ModalEditProduct: UIViewController{
    
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
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    var productToEdit = Product()
    
    
    
    override func viewDidLoad() {
        
        self.editName.text = productToEdit.name
        self.editDescription.text = productToEdit.description
        self.editPrice.text = productToEdit.price
        self.editQuantity.text = productToEdit.price
        self.editS.text = String(productToEdit.sizeS)
        self.editM.text = String(productToEdit.sizeM)
        self.editL.text = String(productToEdit.sizeL)
        self.editXL.text = String(productToEdit.sizeXL)
        self.editXXL.text = String(productToEdit.sizeXXL)
        
    }
    
    func configure( item: Product){
        productToEdit = item
       
    }
    
}
