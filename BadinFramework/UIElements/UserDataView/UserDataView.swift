//
//  UserDataView.swift
//  genericappios
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//


import UIKit

@IBDesignable class UserDataView: UIView  {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userType: UILabel!


    @IBOutlet weak var cardNumber: UILabel!
    
    
    
    @IBOutlet weak var cardStatusLabel: UILabel!
    @IBOutlet weak var cardStatus: UILabel!
    
    @IBOutlet weak var memberSince: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var memberRank: UILabel!
    
    
    @IBOutlet weak var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
        cardStatusLabel.isHidden = true
        cardStatus.isHidden = true

        rankLabel.isHidden = true
        memberRank.isHidden = true
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        backgroundColor = UIColor.clear

    }
    
     
    fileprivate func xibSetup() {
        view = loadViewFromNib()
        
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
          backgroundColor = UIColor.clear
        addSubview(view)
    }
    
    // manipulate elements after Nib is loaded (all visual components)
    override func awakeFromNib() {
        
        // put "done" in keyboard if there is no nextField
        // it has to be done here as the outlets are NIBs and they are not available at init() state
           }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "UserDataView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }


}
