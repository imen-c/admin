//
//  AddProductViewController.swift
//  admin
//
//  Created by imen cheref on 05/09/2023.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var returnButton: UIButton!
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
    
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var addCategoryButton: UIButton!
    @IBOutlet weak var imageInputView: InputImageView!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
