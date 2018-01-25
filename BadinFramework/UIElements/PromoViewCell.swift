//
//  TransactionViewCell.swift
//  genericappios
//
//  Created by DC on 01/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class PromoViewCell: UITableViewCell {
    
    @IBOutlet weak var promoImg: UIImageView!
    @IBOutlet weak var promoName: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
