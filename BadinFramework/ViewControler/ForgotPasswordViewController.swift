//
//  ForgotPasswordViewController.swift
//  genericappios
//
//  Created by DC on 10/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import UIKit


class ForgotPasswordViewController: BaseViewController {
    
    
    
    @IBOutlet weak var emailAddress: TextInputLayout!
    override func viewDidLoad() {
        super.viewDidLoad()

        setBack()
    }
    
    
    @IBOutlet weak var email: TextInputLayout!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        
        let member = Member()
        self.view.endEditing(true)

        member?.emailAddress = emailAddress.text
        startProgress(dataToLoad: 1)
        ApiCalls.resetPassword(member!, success: handleSuccessful, failure: handleFailed)
    }
    
    
    
    
    func handleSuccessful(_ err: Bool) {
        //TODO show message and return to login screen
        stopProgress()
        showToast(message: "To reset password, please check email")

        
        
    }
    
    
    
    func handleFailed(_ err: ErrorResponse) {
        
        //TODO show error message
        stopProgress()
        showToast(message: err.userErrorMessage)

    }
    
    
}
