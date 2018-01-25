//
//  TextInputLayout.swift
//  genericappios
//
//  Created by DC on 06/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit




enum placeholderDirection: String {
    case placeholderUp = "up"
    case placeholderDown = "down"
    
}
class TextInputLayout: UITextField {
    var enableMaterialPlaceHolder : Bool = true
    var placeholderAttributes = NSDictionary()
    var lblPlaceHolder = UILabel()
    
    var errorPlaceHolder = UILabel()
    
    var defaultFont = UIFont()
    var difference: CGFloat = 25.0
    var directionMaterial = placeholderDirection.placeholderUp
    var isUnderLineAvailabe : Bool = true
    var underLine = UIImageView()
    var minusWidth = 30
    var canEdit: Bool = true
    override init(frame: CGRect) {
        super.init(frame: frame)
        Initialize ()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Initialize ()
    }
    func Initialize(){
        
        self.clipsToBounds = false
        self.addTarget(self, action: #selector(TextInputLayout.startEdit), for: .editingDidBegin)
        
        self.addTarget(self, action: #selector(TextInputLayout.endEdit), for: .editingDidEnd)
        self.addTarget(self, action: #selector(TextInputLayout.endEdit), for: .valueChanged)
        
        self.EnableMaterialPlaceHolder(enableMaterialPlaceHolder: true)
        
        self.errorPlaceHolder.alpha = 1
        self.errorPlaceHolder.textColor = UIColor.init(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.8)
        //let fontSize = self.font!.pointSize;
        
        /* Test of automatic font adjusment */
        
        let fontSize = self.font!.pointSize
        
        let screen = UIScreen.main
        var newFontSize = screen.bounds.size.width * (fontSize / 667.0)
        if (screen.bounds.size.height < 500) {
            newFontSize = screen.bounds.size.width * (fontSize / 480.0)
        }
        
        self.errorPlaceHolder.font = UIFont.init(name: (self.font?.fontName)!, size: newFontSize)
        
        
        /* END */
        
        
        
        // self.errorPlaceHolder.font = UIFont.init(name: (self.font?.fontName)!, size: fontSize-3)
        self.errorPlaceHolder.text = "This field is mandatory"
        
        self.errorPlaceHolder.frame = CGRect(x : self.frame.size.width - 140, y : 0 , width : self.frame.size.width, height : self.frame.size.height)
        self.addSubview(self.errorPlaceHolder)
        self.errorPlaceHolder.isHidden = true
        defaultFont = self.font!
        
    }
    @IBInspectable var placeHolderColor: UIColor? = UIColor.darkGray {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder! as String ,
                                                            attributes:[NSAttributedStringKey.foregroundColor: placeHolderColor!])
            
        }
    }
    
   // var placeHolderColorDeSel: UIColor?
    
    @IBInspectable var loginView: Bool = false
        {
        didSet {
            if (loginView) {
                minusWidth = 75
            }
            if isUnderLineAvailabe {
                underLine.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.8)
                //            underLine.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)
                underLine.frame = CGRect(x: 0, y: Int(self.frame.size.height-1), width : Int(UIScreen.main.bounds.width)-minusWidth, height : 1)
                
                underLine.clipsToBounds = true
                self.addSubview(underLine)
            }
            
        }
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if canEdit // Avoid cut and paste option show up
        {   if (action == #selector(self.cut(_:))) {
            return false
        } else if (action == #selector(self.paste(_:))) {
            return false
            }
        }
        
        return super.canPerformAction(action, withSender: sender)
        
    }
    
    override public var text : String? {
        didSet {
            //self.text = text
            endEdit()
        }
    }
    
    
    override internal var placeholder:String?  {
        didSet {
            //  NSLog("placeholder = \(placeholder)")
        }
        willSet {
            let atts  = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.lightGray, NSAttributedStringKey.font: UIFont.labelFontSize] as! [NSAttributedStringKey : Any]
            self.attributedPlaceholder = NSAttributedString(string: newValue!, attributes:atts)
            self.EnableMaterialPlaceHolder(enableMaterialPlaceHolder: self.enableMaterialPlaceHolder)
        }
        
    }
    override internal var attributedText:NSAttributedString?  {
        didSet {
            //  NSLog("text = \(text)")
        }
        willSet {
            if (self.placeholder != nil) && (self.text != "")
            {
                let string = NSString(string : self.placeholder!)
                self.placeholderText(string)
            }
            
        }
    }
    @objc func startEdit(){
        if self.enableMaterialPlaceHolder {
            self.errorPlaceHolder.isHidden = true
            
            underLine.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.8)
            
            self.lblPlaceHolder.alpha = 1
            self.attributedPlaceholder = nil
            self.lblPlaceHolder.textColor = self.placeHolderColor
            let fontSize = self.font!.pointSize;
            self.lblPlaceHolder.font = UIFont.init(name: (self.font?.fontName)!, size: fontSize-3)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {() -> Void in
                
                if self.directionMaterial == placeholderDirection.placeholderUp {
                    self.lblPlaceHolder.frame = CGRect(x : self.lblPlaceHolder.frame.origin.x, y : -self.difference, width : self.frame.size.width, height : self.frame.size.height)
                }else{
                     self.lblPlaceHolder.frame = CGRect(x : self.lblPlaceHolder.frame.origin.x, y : self.difference, width : self.frame.size.width, height : self.frame.size.height)
                }
                
                
            }, completion: {(finished: Bool) -> Void in
            })
        }
    }
    
    @objc func endEdit(){
        if self.enableMaterialPlaceHolder {
            if (self.text == nil) || (self.text?.characters.count)! > 0 {
                self.lblPlaceHolder.alpha = 1
                self.attributedPlaceholder = nil
                self.lblPlaceHolder.textColor = self.placeHolderColor
                let fontSize = self.font!.pointSize;
                self.lblPlaceHolder.font = UIFont.init(name: (self.font?.fontName)!, size: fontSize-3)
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {() -> Void in
                if (self.text == nil) || (self.text?.characters.count)! <= 0 {
                    self.lblPlaceHolder.font = self.defaultFont
 
                    self.lblPlaceHolder.frame = CGRect(x: self.lblPlaceHolder.frame.origin.x, y : 0, width :self.frame.size.width, height : self.frame.size.height)
                }
                else {
                    if self.directionMaterial == placeholderDirection.placeholderUp {
                        self.lblPlaceHolder.frame = CGRect(x : self.lblPlaceHolder.frame.origin.x, y : -self.difference, width : self.frame.size.width, height : self.frame.size.height)
                    }else{
 
                        self.lblPlaceHolder.frame = CGRect(x : self.lblPlaceHolder.frame.origin.x, y : self.difference, width : self.frame.size.width, height : self.frame.size.height)
                    }
                    
                }
            }, completion: {(finished: Bool) -> Void in
            })
        }
    }
    func setErrorMandatory(){
        
    }
    
    func isError() {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = UIColor.black.cgColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        animation.autoreverses = true
        self.layer.add(animation, forKey: "")
        
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = 2
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
        underLine.backgroundColor = UIColor.init(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.8)
        self.lblPlaceHolder.textColor =  UIColor.init(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.8)
        self.errorPlaceHolder.isHidden = false
        
        
    }
    
    func EnableMaterialPlaceHolder(enableMaterialPlaceHolder: Bool){
        self.enableMaterialPlaceHolder = enableMaterialPlaceHolder
        self.lblPlaceHolder = UILabel()
        self.lblPlaceHolder.frame = CGRect(x: 0, y : 0, width : 0, height :self.frame.size.height)
        self.lblPlaceHolder.font = UIFont.systemFont(ofSize: 10)
        self.lblPlaceHolder.alpha = 0
        self.lblPlaceHolder.clipsToBounds = true
       // self.placeHolderColorDeSel = UIColor.init(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.8)
        self.addSubview(self.lblPlaceHolder)
        self.lblPlaceHolder.attributedText = self.attributedPlaceholder
        //self.lblPlaceHolder.sizeToFit()
    }
    func placeholderText(_ placeholder: NSString){
        let atts  = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.darkGray, NSAttributedStringKey.font: UIFont.labelFontSize] as! [NSAttributedStringKey : Any]
        self.attributedPlaceholder = NSAttributedString(string: placeholder as String , attributes:atts)
        self.EnableMaterialPlaceHolder(enableMaterialPlaceHolder: self.enableMaterialPlaceHolder)
    }
    override func becomeFirstResponder()->(Bool){
        let returnValue = super.becomeFirstResponder()
        return returnValue
    }
    override func resignFirstResponder()->(Bool){
        let returnValue = super.resignFirstResponder()
        return returnValue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
