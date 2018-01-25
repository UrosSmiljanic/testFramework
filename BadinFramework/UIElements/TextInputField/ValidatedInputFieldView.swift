//
//  ValidatedInputFieldView.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

@IBDesignable class ValidatedInputFieldView: UIView  {
    
    // Our custom view from the XIB file
    var view: UIView!
    
    fileprivate var defaultTitleText: String?
    fileprivate var defaultContentText: String?
    
    @IBOutlet var titleText: UILabel!
    @IBOutlet var contentTextField: UIUnderlineTextField!
    @IBOutlet var nextField:ValidatedInputFieldView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
        setInitialState()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        setInitialState()
    }
    
    fileprivate func setInitialState() {
        
        // hides the title on load. used to make developing convinient as title shows during development
        titleText.isHidden = true;
        

        
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
        if nextField == nil {
            contentTextField.returnKeyType = UIReturnKeyType.done
        }
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ValidatedInputFieldView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    // Empty the Text Box when it gets focus only if content is same as title and show title
    @IBAction func inputFieldBeginEditing(_ sender: AnyObject) {
        if contentTextField.text!.caseInsensitiveCompare(defaultTitleText!) == ComparisonResult.orderedSame {
            contentTextField.text = ""
            titleText.isHidden = false;
        }
    }
    
    // When exiting the field if its empty hide the title and make text default to original value again.
    @IBAction func inputFieldEndEditing(_ sender: AnyObject) {
        if contentTextField.text!.isEmpty {
            titleText.isHidden = true
            contentTextField.text = defaultContentText
        }
    }
    
    @IBInspectable var returnKeyType: UIReturnKeyType {
        get {
            return self.contentTextField.returnKeyType
        }
        set(returnKeyType) {
            self.contentTextField.returnKeyType = returnKeyType
        }
    }
    
    @IBInspectable var title: String? {
        get {
            return self.titleText.text
        }
        set(title) {
            defaultTitleText = title
            self.titleText.text = title
        }
    }
    
    @IBInspectable var content: String? {
        get {
            return self.contentTextField.text
        }
        set(content) {
            defaultContentText = content
            self.contentTextField.text = content
        }
    }
    
    @IBInspectable var textColor: UIColor? {
        didSet {
            contentTextField.textColor = textColor
            titleText.textColor = textColor
        }
    }
    
    @IBInspectable var underlineColor: UIColor? {
        didSet {
            contentTextField.setBorderBoxColor((underlineColor?.cgColor)!)
        }
    }
    
}
