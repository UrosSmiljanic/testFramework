//
//  UIUnderlineTextField.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class UIUnderlineTextField: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var borderBox = CALayer()
    
    internal required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        backgroundColor = UIColor.clear
        
        let borderWidth = CGFloat(2)
                
//        borderBox.borderColor = UIColor.whiteColor().CGColor
        
        borderBox.frame = CGRect(x: 0, y: frame.height - borderWidth, width: frame.size.width, height: frame.size.height)
        borderBox.borderWidth = borderWidth
        
        self.layer.addSublayer(borderBox)
        print(borderBox.frame.size)
        
        print("Underlined family:" + self.font!.fontName)
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y,
            width: bounds.size.width, height: bounds.size.height - 10);
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)

    }
    
    func setBorderBoxColor(_ color:CGColor) {
        borderBox.borderColor = color
    }
    
}
