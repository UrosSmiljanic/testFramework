//
//  LastTransactionView.swift
//  genericappios
//
//  Created by DC on 04/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

@IBDesignable class LastTransactionView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
        
    }
    @IBOutlet var view: UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        backgroundColor = UIColor.clear
        //view.bounds = view.frame.insetBy(dx: 10.0, dy: 10.0)
        

        
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
        let nib = UINib(nibName: "LastTransactionView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
   

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var text: UILabel!

}
