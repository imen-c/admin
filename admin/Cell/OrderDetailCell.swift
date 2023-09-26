//
//  OrderDetailCell.swift
//  admin
//
//  Created by imen cheref on 26/09/2023.
//

import UIKit
import Alamofire
import AlamofireImage

class OrderDetailCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stockGenericLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    
    var orderLine = OrderLine()
    var sizeStock : [String: Int] = ["sizeS": 0, "sizeM": 0, "sizeL":0, "sizeXL": 0, "sizeXXL": 0]
    var imageLink = ""
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func configure(line: OrderLine){
        self.orderLine = line
        self.sizeStock["sizeS"] = orderLine.sizeS
        self.sizeStock["sizeM"] = orderLine.sizeM
        self.sizeStock["sizeL"] = orderLine.sizeL
        self.sizeStock["sizeXL"] = orderLine.sizeXL
        self.sizeStock["sizeXXL"] = orderLine.sizeXXL
        
        self.nameLabel.text = orderLine.productName
        self.sizeLabel.text = orderLine.chosenSize
        
        if let q = orderLine.qty{
            let qty = String(q)
            self.quantityLabel.text = "x\(qty)"
        }

        for(size, _) in sizeStock{
            if(size == orderLine.chosenSize){
                self.stockLabel.text = String(sizeStock[size] ?? 0)
                
            }
           
        }
        
        var link = GlobalData.shared.endPointImage
        if let iN = orderLine.productImage{
            
             imageLink = link + iN
            
        }
        print("IMAGE LINK")
        print(imageLink)
        AF.request(imageLink).responseImage { response in
            if let image = response.value {
                self.imageCell.image = image
            }
        }
    }
    
}
