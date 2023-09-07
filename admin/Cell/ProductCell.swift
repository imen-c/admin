//
//  ProductCell.swift
//  admin
//
//  Created by imen cheref on 07/09/2023.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var sizeS: UILabel!
    @IBOutlet weak var sizeM: UILabel!
    @IBOutlet weak var sizeL: UILabel!
    @IBOutlet weak var sizeXL: UILabel!
    @IBOutlet weak var sizeXXL: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
