//
//  TransactionViewCell.swift
//  genericappios
//
//  Created by DC on 01/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class TransactionViewCell: UITableViewCell {

    @IBOutlet weak var transMerchant: UILabel!
    @IBOutlet weak var transDate: UILabel!
    @IBOutlet weak var transValue: UILabel!
    @IBOutlet weak var transType: UILabel!
    @IBOutlet weak var transDetails: UILabel!
     override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
