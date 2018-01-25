//
//  ReplaceCardViewController.swift
//  genericappios
//
//  Created by DC on 10/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class ReplaceCardViewController: BaseViewController , UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCardNumber.text =  KeychainWrapper.standard.string(forKey: "cardNumber")!
        newCardNumber.delegate = self
       // makePrefix()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   /* func makePrefix() {
        let attributedString = NSMutableAttributedString(string: "62760469")
         newCardNumber.attributedText = attributedString
    }*/
    
    
    @IBOutlet weak var currentCardNumber: TextInputLayout!
    
    @IBOutlet weak var newCardNumber: TextInputLayout!
    @IBAction func replaceCardAction(_ sender: Any) {
        /* a.setFlUpdate("0");
         a.setLogin(session.getMemberSessionData().getIdentifier());
         a.setOldCardNumber(session.getMemberSessionData().getIdentifier());
         a.setNewCardNumber(etNewCard.getText().toString());
         a.setPassword(session.getMemberSessionData().getMemberPassword());
         a.setRequestType("NewCard");
         a.setProgramID("182");*/
        
        let replaceCard = ReplaceCard()
        replaceCard.flUpdate = "0"
        replaceCard.login = KeychainWrapper.standard.string(forKey: "userName")!
        replaceCard.oldCardNumber = currentCardNumber.text
        replaceCard.newCardNumber = newCardNumber.text
        replaceCard.password = KeychainWrapper.standard.string(forKey: "password")!
        replaceCard.requestType = "NewCard"
        replaceCard.programID = "182"
        self.view.endEditing(true)

        ApiCalls.replaceCard(replaceCard,  success: handleSuccessful, failure: handleFailed)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            
            let minLength = 8
            let maxLength = 16

            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length >= minLength && newString.length <= maxLength
        
    }
    
    
    func handleSuccessful(_ err: Bool) {
        KeychainWrapper.standard.set(newCardNumber.text!, forKey: "cardNumber")
        currentCardNumber.text =  KeychainWrapper.standard.string(forKey: "cardNumber")!

        showToast(message: "Card successfully replaced")
        stopProgress()
        
        
        
    }
    
    
    
    func handleFailed(_ err: ErrorResponse) {
        
        showToast(message: "Error replacing card, please contact support.")
        stopProgress()
        
    }
    
    
    
}
