//
//  ProgressBarView.swift
//  genericappios
//
//  Created by DC on 06/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import UIKit
import UICircularProgressRing

protocol ProgressBarDelegate{
    func refresh( balance : String)
}
class ProgressBarView: UIView  {
    var delegate:ProgressBarDelegate! = nil

    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var userName: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        reloadButton.isHidden = false
        
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
        let nib = UINib(nibName: "ProgressBarView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    @IBOutlet weak var ring1: UICircularProgressRingView!
    @IBOutlet weak var reloadButton: UIButton!
    var balance : CGFloat!
    @IBAction func reload(_ sender: Any) {
        startProgress()
        reloadButton.isHidden = true
        ApiCalls.getMember(  success: handleSuccessfulLogin, failure: handleFailedLogin)
        
        
    }
    
    func handleSuccessfulLogin(_ member: Member) {
        guard let n = NumberFormatter().number(from: member.loyaltyBalance!) else {
            stopProgress()
            ring1.animationStyle = kCAMediaTimingFunctionLinear
            ring1.setProgress(value: balance, animationDuration: 2, completion: nil)
            ring1.fontColor = UIColor.black
            delegate.refresh(balance: NSString(format: "%", balance) as String)
          
            return
        }
       

        balance = CGFloat (truncating: n)
        stopProgress()
        ring1.animationStyle = kCAMediaTimingFunctionLinear
        ring1.setProgress(value: balance, animationDuration: 2, completion: nil)
        ring1.fontColor = UIColor.black
        delegate.refresh(balance: member.loyaltyBalance!)
 //       delegate.refresh(balance: NSString(format: "%", balance) as String)
        _ = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)

        
    }
    
    @objc func update() {
     reset()
        
    }
    func handleFailedLogin(_ err: ErrorResponse) {
        stopProgress()
        ring1.animationStyle = kCAMediaTimingFunctionLinear
        ring1.setProgress(value: balance, animationDuration: 2, completion: nil)
        ring1.fontColor = UIColor.black
     }
    
    open func reset(){
        ring1.animationStyle = kCAMediaTimingFunctionLinear
        ring1.fontColor = UIColor.clear

        ring1.setProgress(value: 0, animationDuration: 0, completion: nil)

        reloadButton.isHidden = false
    }
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    func startProgress()
    {
        activityIndicator.center = self.ring1.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    
    func stopProgress()
    {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
