//
//  MessageViewCell.swift
//  admin
//
//  Created by imen cheref on 15/09/2023.
//

import UIKit

class MessageViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var subjectName: UILabel!
    var date = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configure(date: String){
        self.date = date
        print("DATE RECU")
        print(date)
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        
        let dateToConvert = dateFormatter.date(from: date)
        let displayDateFormatter = DateFormatter()
               displayDateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let dateToConvert = dateToConvert{
            
            let formattedDate = displayDateFormatter.string(from: dateToConvert)
            self.dateLabel.text = formattedDate
            
            // Ajourdhui
            let todayDateFormatter = DateFormatter()
                todayDateFormatter.dateFormat = "dd/MM/yyyy"
            let todayDateString = todayDateFormatter.string(from: Date())
            
            if formattedDate == todayDateString {
                self.dateLabel.text = "Aujourd'hui"
                  }

        }
        
        
    }
}
