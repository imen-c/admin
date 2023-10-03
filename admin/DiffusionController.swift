//
//  DiffusionController.swift
//  admin
//
//  Created by imen cheref on 20/09/2023.
//

import UIKit

class DiffusionController: UIViewController {
    
    
    @IBOutlet weak var titleNotif: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editLabel: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var editText: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    
    @IBOutlet weak var panoramaTitle: UILabel!
    @IBOutlet weak var image1: InputImageView!
    @IBOutlet weak var image2: InputImageView!
    @IBOutlet weak var image3: InputImageView!
    @IBOutlet weak var recordButton: UIButton!
    

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
