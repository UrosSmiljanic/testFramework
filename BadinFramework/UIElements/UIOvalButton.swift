//
//  UIOvalButton.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

@IBDesignable class UIOvalButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adverasely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    fileprivate func setup() {
        titleEdgeInsets.bottom = 30
        titleEdgeInsets.top = 30
        
        self.setTitleColor(UIColor.white, for: UIControlState())
        self.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18)
    }
    
    override var intrinsicContentSize : CGSize {
        
        let intrinsicContentSize = super.intrinsicContentSize
        
        let adjustedWidth = intrinsicContentSize.width + titleEdgeInsets.left + titleEdgeInsets.right
        let adjustedHeight = intrinsicContentSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom
        
        return CGSize(width: adjustedWidth, height: adjustedHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setHalfCircleSides()        
    }
    
    
    //MARK: Inital setup
    fileprivate func setHalfCircleSides() {
        debugPrint("Bounds: [\(self.bounds.height),\(self.bounds.width)]")
        self.layer.cornerRadius = self.bounds.height * 0.5        
    }
    
}
