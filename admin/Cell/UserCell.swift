//
//  UserCell.swift
//  admin
//
//  Created by imen cheref on 17/09/2023.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var ordersCount: UILabel!
    
    @IBOutlet weak var messageCount: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
