//
//  ChangePasswordViewController.swift
//  genericappios
//
//  Created by DC on 10/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var current: TextInputLayout!
    @IBOutlet weak var new: TextInputLayout!
    @IBOutlet weak var newRepeat: TextInputLayout!
    @IBAction func changePassword(_ sender: Any) {
        self.view.endEditing(true)

        if newRepeat.text != new.text
        {
            showToast(message: "New password is not the same")
        }
        else
            if current.text != KeychainWrapper.standard.string(forKey: "password")!
            {
                showToast(message: "Wrong old password")
            }
            else
            {
                let member = Member()
                member?.password = new.text
                startProgress(dataToLoad: 1)
                ApiCalls.updateDetails(member!, success: handleSuccessful, failure: handleFailed)
        }
    }
    
    
    
    
    func handleSuccessful(_ err: Bool) {
        //TODO show message      
        stopProgress()
        showToast(message: "Password succesfuly changed")

        KeychainWrapper.standard.set(new.text!, forKey: "password")

        
    }
    
    
    
    func handleFailed(_ err: ErrorResponse) {
        
         stopProgress()
        showToast(message: err.userErrorMessage)

    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
