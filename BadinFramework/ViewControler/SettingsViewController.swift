//
//  SettingsViewController.swift
//  genericappios
//
//  Created by DC on 06/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.updateDetails.addGestureRecognizer(gesture)
        
        let gesture1 = UITapGestureRecognizer(target: self, action:  #selector (self.changePasswordAction (_:)))
        self.changePassword.addGestureRecognizer(gesture1)
        
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (self.replaceCardPasswordAction (_:)))
        self.replaceCard.addGestureRecognizer(gesture2)

        let gesture3 = UITapGestureRecognizer(target: self, action:  #selector (self.helpAction (_:)))
        self.help.addGestureRecognizer(gesture3)
        
        let gesture4 = UITapGestureRecognizer(target: self, action:  #selector (self.appsettingsAction (_:)))
        self.appsettings.addGestureRecognizer(gesture4)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    func btnPressed() {
        print("button pressed!")
    }
    
    @IBOutlet weak var updateDetails: UIView!
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
       
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "updatedetails") as! UpdateDetailsViewController
        self.navigationController?.pushViewController(nextViewController, animated:false )
    }
    
    
    @objc func changePasswordAction(_ sender:UITapGestureRecognizer){
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "changepassword") as! ChangePasswordViewController
        self.navigationController?.pushViewController(nextViewController, animated:false )
    }
    
    
    @objc func replaceCardPasswordAction(_ sender:UITapGestureRecognizer){
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "replacecard") as! ReplaceCardViewController
        self.navigationController?.pushViewController(nextViewController, animated:false )
    }
    
    @objc func helpAction(_ sender:UITapGestureRecognizer){
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "help") as! HelpAboutViewController
        self.navigationController?.pushViewController(nextViewController, animated:false )
    }
    
    @objc func appsettingsAction(_ sender:UITapGestureRecognizer){
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "appsettings") as! AppSettingsViewController
        self.navigationController?.pushViewController(nextViewController, animated:false )
    }
    
    
    
    @IBOutlet weak var changePassword: UIView!
    @IBOutlet weak var replaceCard: UIView!
    @IBOutlet weak var help: UIView!
    @IBOutlet weak var appsettings: UIView!
}
