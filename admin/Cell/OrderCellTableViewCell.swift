//
//  OrderCellTableViewCell.swift
//  admin
//
//  Created by imen cheref on 20/09/2023.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var itemNumber: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var totalOrder = 0.00
    var pieces = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(item: Order){
        
        self.email.text = item.customer.email

        
        // DATE

        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        
        let dateToConvert = dateFormatter.date(from: item.createdAt ?? "")
        let displayDateFormatter = DateFormatter()
               displayDateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let dateToConvert = dateToConvert{
            
            let formattedDate = displayDateFormatter.string(from: dateToConvert)
            self.date.text = formattedDate
            
            // Ajourdhui
            let todayDateFormatter = DateFormatter()
                todayDateFormatter.dateFormat = "dd/MM/yyyy"
            let todayDateString = todayDateFormatter.string(from: Date())
            
            if formattedDate == todayDateString {
                self.date.text = "Aujourd'hui"
                  }

        }
        
        
    }
    
}
