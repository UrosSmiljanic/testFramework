//
//  QRCodeView.swift
//  genericappios
//
//  Created by ST on 23/02/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import UIKit
import QRCode


@IBDesignable class QRCodeView : UIView {
    
    
    @IBOutlet var mainView: UIView!
    
    
    @IBOutlet weak var qrCodeImage: UIImageView!
    
    @IBOutlet weak var rewardsBalance: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
         loadQr()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
          loadQr()
        
    }
    
      func loadQr(){
        let qrCode=QRCode("test")
        qrCodeImage.image=qrCode?.image
    }

    func loadQrCard(card:String){
        let qrCode=QRCode(card)
        qrCodeImage.image=qrCode?.image
    }
  

 
    func xibSetup() {
        mainView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        mainView.frame = bounds
        
        // Make the view stretch with containing view
        mainView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(mainView)
    }
    
    func loadViewFromNib() -> UIView {
        
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "QRCodeView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
        
    }
    
}
