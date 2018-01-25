//
//  UITextField.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    var substituteFontName : String {
        get { return self.font!.fontName }
        set { self.font = UIFont(name: newValue, size: self.font!.pointSize) }
    }
    
}

