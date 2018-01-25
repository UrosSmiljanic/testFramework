//
//  StoreItemTableViewCell.swift
//  genericappios
//
//  Created by DC on 08/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class StoreItemTableViewCell: UITableViewCell {

    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDistance: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
