//
//  ImageButton.swift
//  genericappios
//
//  Created by DC on 06/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class ImageButton: NSObject {
    
    class myButton : UIButton {
        override var isHighlighted: Bool {
            didSet {
                if (isHighlighted) {
                    self.backgroundColor = UIColor.blue
                } else {
                    self.backgroundColor = UIColor.white
                }
            }
        }
    }
    
}
