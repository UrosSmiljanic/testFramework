//
//  ViewControllerUtils.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import UIKit

open class ViewControllerUtils {
    
    open static func nextResponder(_ textField: UITextField) -> Bool {
        let myView = getParentView(textField)
        if let nextResponder = myView.nextField?.contentTextField {
            nextResponder.becomeFirstResponder()
        }
        else {
            let didResign = textField.resignFirstResponder()
            if (!didResign) {
                return false;
            }
        }
        return false
        
    }
    
    fileprivate static func getParentView(_ view: UIView) -> ValidatedInputFieldView {
        let myView = view.superview
        if(myView is ValidatedInputFieldView) {
            return myView as! ValidatedInputFieldView
        }
        else {
            return getParentView(myView!)
        }
    }
    
    
    
}
