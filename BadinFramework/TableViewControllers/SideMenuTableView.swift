//
//  SideMenuTableView.swift
//  genericappios
//
//  Created by DC on 05/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import SideMenu
import Firebase

import FirebaseCore

class SideMenuTableView: UITableViewController {
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("SideMenu Appearing!")
        
        // this will be non-nil if a blur effect is applied
        guard tableView.backgroundView == nil else {
            return
        }
        
        // Set up a cool background image for demo purposes
        
        tableView.backgroundColor = UIColor(red: 254.0/255.0, green: 206.0/255.0, blue: 20.0/255.0, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("SideMenu Appeared!")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("SideMenu Disappearing!")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("SideMenu Disappeared!")
    }
    
    
    
    @IBAction func facebooks(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "webView") as! WebViewController
        nextViewController.urlS="https://www.facebook.com/ColumbusCoffeeNZ"
        self.navigationController?.pushViewController(nextViewController, animated:false )
        
    }
    
    @IBAction func instas(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "webView") as! WebViewController
        nextViewController.urlS="https://vibbi.com/columbuscoffeenz"
        self.navigationController?.pushViewController(nextViewController, animated:false )
    }
    
    @IBAction func youtubes(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "webView") as! WebViewController
        nextViewController.urlS="https://www.youtube.com/channel/UCXuhQ6_d0_lQT6qEsLKgJ3Q"
        self.navigationController?.pushViewController(nextViewController, animated:false )
    }
    var ref: DatabaseReference!

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if (indexPath.item == 6 )
            
        {
           
            ref = Database.database().reference()
            if KeychainWrapper.standard.string(forKey: "notification_token") != nil
            {
            self.ref.child("ios_token_expire").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.string(forKey: "notification_token")!);
                let token = KeychainWrapper.standard.string(forKey: "notification_token")!
                KeychainWrapper.standard.set(token, forKey: "notification_token")

            
            }
            KeychainWrapper.wipeKeychain()
         //   viewWillDisappear(false)
          //  viewDidDisappear(false)

//            var navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//
//            let nextViewController =  navigationController.visibleViewController as! BaseViewController
//            nextViewController.dismissMenu()
            
            /*
             
             Part from AppDelegate.swift
             
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.resetAppToFirstController()
            
            */
            
            
            
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
//
//
//            navigationController.pushViewController(nextViewController, animated: true)

        }
        
        
    }
    
    
    
}
