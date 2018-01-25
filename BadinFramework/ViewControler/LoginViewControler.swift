    //
    //  ViewController.swift
    //  MobileApplication
    //
    //  Created by Dusan on 23/01/2017.
    //  Copyright © 2017 Dusan. All rights reserved.
    //
    
    import UIKit
    import Alamofire
    import Firebase

    import FirebaseCore
    
    class LoginViewController: UIViewController, UITextFieldDelegate , CodeScanedDelegate{
        private var loginInProgress = false
        private var userData: UserDefaults?
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "qrscan"{
                let vc = segue.destination as! QRScannerController
                vc.delegate = self
            }
        }
        
        func scanned(value: String){
            
            cardNumber.text =  value.components(separatedBy: "#")[0]
            if (!loginInProgress){
                if ( value.components(separatedBy: "#").count > 1){
                    pinPassword.text =             value.components(separatedBy: "#")[1]
                    loginButtonPressed(UIOvalButton())
                }
            }
        }
        @IBAction func visiblePassword(_ sender: Any) {
            pinPassword.isSecureTextEntry = !pinPassword.isSecureTextEntry
        }
        
        
        @IBOutlet weak var cardNumber: TextInputLayout!
        @IBOutlet weak var pinPassword: TextInputLayout!
        @IBOutlet weak var errorMessageLabel: UILabel!
        
        @IBOutlet weak var notAMemberBtn: UIButton!
        fileprivate var counter:Int = 0
        @IBOutlet var mainContainer: UIView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
            
            
            errorMessageLabel.backgroundColor = Colors.invalidatedColor
            errorMessageLabel.isHidden = true
            
            userData = UserDefaults.standard
            var user_logged_in = 0
            if (userData?.object(forKey: "user_logged_in") != nil) {
                user_logged_in = userData?.object(forKey: "user_logged_in") as! Int
                
                
                if (user_logged_in != 0)
                {
                    userData?.set(0, forKey: "user_logged_in")
                    let username = userData?.object(forKey: "username") as! String
                    let password = userData?.object(forKey: "password") as! String
                    cardNumber.text = username
                    pinPassword.text = password
                    loginButtonPressed(UIOvalButton())
                }
            }
            else if (KeychainWrapper.standard.string(forKey: "tempPassR") != nil){
            if  (KeychainWrapper.standard.string(forKey: "tempPassR")! != ""){
                pinPassword.text = KeychainWrapper.standard.string(forKey: "tempPassR")!
                cardNumber.text = KeychainWrapper.standard.string(forKey: "tempCardR")!
                KeychainWrapper.standard.set("", forKey: "tempPassR")

                }}
            else if (KeychainWrapper.standard.string(forKey: "tempPassRe") != nil){
                if  (KeychainWrapper.standard.string(forKey: "tempPassRe")! != ""){
                    pinPassword.text = KeychainWrapper.standard.string(forKey: "tempPassR")!
                    cardNumber.text = KeychainWrapper.standard.string(forKey: "tempCardR")!
                    KeychainWrapper.wipeKeychain()
                    loginButtonPressed(UIOvalButton()) 
                    
                }}
        }
        
        
        
        //Calls this function when the tap is recognized.
        @objc func dismissKeyboard() {
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            view.endEditing(true)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        @IBAction func loginButtonPressed(_ sender: UIOvalButton) {
            var error = false
            loginInProgress = true
            
            
            if ( cardNumber.text == "" )
            {  cardNumber.isError()
                error = true }
            
            
            
            if ( pinPassword.text == "" )
            {  pinPassword.isError()
                error = true }
            
            if (error == false)
            {
                startProgress()
                errorMessageLabel.isHidden = false
                
                self.view.isUserInteractionEnabled = false
                //             performSegue(withIdentifier: "LoginSuccessful", sender: self)
                dismissKeyboard()
                revertToValidState()
                debugPrint("Login attemp started.")
                // send request
                let credentials:Login = Login(uname: cardNumber.text!, pass: pinPassword.text!)
                Tokens.create(credentials, success: handleSuccessfulLogin, failure: handleFailedLogin)
                return
            }
            
        }
        
        @IBAction func gotoRegisterAction(_ sender: AnyObject) {
            dismissKeyboard()
            revertToValidState()
            debugPrint("Customer wants to register.")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "register") as! RegisterViewController
            
            self.navigationController?.pushViewController(nextViewController, animated:false )
            
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            return ViewControllerUtils.nextResponder(textField)
            
        }
        
        
        func invalidateInputFields() {
            //  cardNumber.underlineColor = Colors.invalidatedColor
            errorMessageLabel.isHidden = false
        }
        
        func revertToValidState() {
            //  cardNumber.underlineColor = UIColor.white
            errorMessageLabel.isHidden = true
        }
        
        
        
        override var preferredStatusBarStyle : UIStatusBarStyle {
            return .lightContent
        }
        
        
        //MARK: API HANDLERS
        func handleSuccessfulLogin(_ token: Token) {
            self.view.isUserInteractionEnabled = true
            
            ApiCalls.getMember(  success: handleSuccessfulMember, failure: handleFailedLogin)
            
            
            //            errorMessageLabel.text = "Successful: " + token.token
            //            stopProgress()
            //
            //            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            //            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "balance") as! HomeScreenViewController
            //            //     self.navigationController!.viewControllers.removeAll()
            //
            //            self.navigationController?.pushViewController(nextViewController, animated:false )
            //
            
            // performSegue(withIdentifier: "LoginSuccessful", sender: self)
        }
        
        var ref: DatabaseReference!
       
        func handleSuccessfulMember(_ member: Member) {
            loginInProgress = false
            
            ref = Database.database().reference()
            if KeychainWrapper.standard.string(forKey: "notification_token") != nil
            {
            self.ref.child("ios_token").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.string(forKey: "notification_token")!);

            }
            if (member.memberStatus?.id == "1817")||(member.memberStatus?.id == "1305")||(member.memberStatus?.id == "3229")
            {
                stopProgress()
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "updatedetails") as! UpdateDetailsViewController
                nextViewController.unreg = true
                KeychainWrapper.standard.set(pinPassword.text!, forKey: "tempPass")
                KeychainWrapper.standard.set(cardNumber.text!, forKey: "tempCard")

                self.navigationController?.pushViewController(nextViewController, animated:false )
                
            }
            else {
                stopProgress()
                //      performSegue(withIdentifier: "LoginSuccessful", sender: self)
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "balance") as! HomeScreenViewController
                //     self.navigationController!.viewControllers.removeAll()
                self.navigationController?.pushViewController(nextViewController, animated:false )

             //   var navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
             //   navigationController.pushViewController(nextViewController, animated: true)
                
                
            }
            // performSegue(withIdentifier: "LoginSuccessful", sender: self)
        }
        
        func handleFailedLogin(_ err: ErrorResponse) {
            // errorMessageLabel.text = "Failed: " + err.userErrorMessage
            errorMessageLabel.text = "Wrong username or password"
            
            errorMessageLabel.isHidden = false
            self.view.isUserInteractionEnabled = true
            loginInProgress = false
            
            stopProgress()
            
        }
        
        
        var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
        
        
        func startProgress()
        {
            activityIndicator.center = self.view.center
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
        
        @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
            
        }
        
    }
