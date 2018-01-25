//
//  MenuView.swift
//  genericappios
//
//  Created by DC on 02/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

@IBDesignable class MenuView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    @IBOutlet weak var balance: UIButton!
    
    
    var progressView: UIProgressView?
    var progressLabel: UILabel?
    
    func addControls() {
        // Create Progress View Control
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
        progressView?.center = self.view.center
        view.addSubview(progressView!)
        
        // Add Label
        progressLabel = UILabel()
        let frame = CGRect(x: view.center.x - 25, y: view.center.y - 100, width:100, height:50)
        progressLabel?.frame = frame
        view.addSubview(progressLabel!)
    }
    
        
    
    @IBAction func test(_ sender: Any) {
        addControls()
        updateProgress() 
    }
    
    func updateProgress() {
        progressView?.progress += 0.05
        let progressValue = self.progressView?.progress
        progressLabel?.text = "\(progressValue! * 100) %"
    }
    
    @IBAction func openBalance(_ sender: UIButton) {
       
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "balance") as! HomeScreenViewController
        vca.present(nextViewController, animated:false, completion:nil)
        
    }
    
    @IBAction func openTransactions(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "transactions") as! TransactionViewController
        vca.present(nextViewController, animated:false, completion:nil)
        
    }
    @IBAction func openStores(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "stores") as! StoreViewController
        vca.present(nextViewController, animated:false, completion:nil)
    }
   
    @IBOutlet var view: UIView!
     var vca=UIViewController()
    init(frame: CGRect, vc: UIViewController) {        super.init(frame: frame)
        xibSetup()
        vca=vc
        view.backgroundColor = UIColor(red: 254.0/255.0, green: 206.0/255.0, blue: 20.0/255.0, alpha: 1.0)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        // backgroundColor = UIColor.clear
        
    }
    
    
    fileprivate func xibSetup() {
        view = loadViewFromNib()
        
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        
        addSubview(view)
    }
    
    // manipulate elements after Nib is loaded (all visual components)
    override func awakeFromNib() {
        
        // put "done" in keyboard if there is no nextField
        // it has to be done here as the outlets are NIBs and they are not available at init() state
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MenuView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    static func getTopViewController() -> UIViewController {
        
        var viewController = UIViewController()
        
        if let vc =  UIApplication.shared.delegate?.window??.rootViewController {
            
            viewController = vc
            var presented = vc
            
            while let top = presented.presentedViewController {
                presented = top
                viewController = top
            }
        }
        
        return viewController
    }
}
