//
//  BaseViewController.swift
//  genericappios
//
//  Created by DC on 01/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import SideMenu


class BaseViewController: UIViewController {
    
    var navBar: UINavigationBar!
    
    
    var sideBack: Bool!
    var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideBack=false
        
        navBar = UINavigationBar(frame: CGRect(x: 0, y: TTLUtils.getNavBarY(), width: Int(self.view.bounds.size.width), height: 60))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "");
        
        let width = navBar.bounds.size.width
        let height = navBar.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x:0, y:0, width:width, height:height))
        imageViewBackground.image = UIImage(named: "logo_transparent")
        imageViewBackground.contentMode = .scaleAspectFit
        navItem.titleView=imageViewBackground
        
        
        
        
    
        button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "ic_drawer"), for: UIControlState.normal)
        button.clipsToBounds = false

        button.addTarget(self, action: #selector(menuAction(sender:)), for: UIControlEvents.touchUpInside)

        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
         let barButton = UIBarButtonItem(customView: button)
        if #available(iOS 9.0, *) {
            button.widthAnchor.constraint(equalToConstant: 40).isActive = true
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        navItem.leftBarButtonItem = barButton;
 
        
        
        
        
        let buttonRight = UIButton.init(type: .custom)
 
        buttonRight.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        if #available(iOS 9.0, *) {
            buttonRight.widthAnchor.constraint(equalToConstant: 40).isActive = true
            buttonRight.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        let barButtonRight = UIBarButtonItem(customView: buttonRight)
        
       navItem.rightBarButtonItem = barButtonRight;
        
        
        navBar.isTranslucent=false
        
        navBar.setItems([navItem], animated: false);
        navBar.barTintColor=UIColor(red: 254.0/255.0, green: 206.0/255.0, blue: 20.0/255.0, alpha: 1.0)
        navBar.shadowImage = UIImage()
        
      
        let menuLeftNavigationController =  storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: navBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view, forMenu: .left)
         SideMenuManager.default.menuFadeStatusBar  = false
        
         dismissMenu() 
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func rotated() {
      /*  if UIDevice.current.orientation.isLandscape {
            
            let bounds = self.navigationController!.navigationBar.bounds
            navBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 60)
            
        } else {
            
            let bounds = self.navigationController!.navigationBar.bounds
            navBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 80)
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBack(){
    
     sideBack = true
     button.setImage(UIImage(named: "btn_back"), for: UIControlState.normal)

    }
    
    
    func setExit(){
        
        sideBack = true
        button.setImage(UIImage(), for: UIControlState.normal)
        
    }
    
    
    // var menu:UIView=UIView()
    var menuOpen=false
    
    @objc func menuAction(sender: Any) {
        if sideBack == false
        {
            
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true )
           
        }
        else
        {
            _ = navigationController?.popViewController(animated: true)
            
        }
        
        // Similarly, to dismiss a menu programmatically, you would do this:
        // dismiss(animated: true, completion: nil)
        
    }
    
    @objc func dismissMenu() {
        
         dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var dataToLoad : Int = 0
    var dataLoaded : Int = 0
    var overlay : UIView?
    func startProgress(dataToLoad : Int)
    {
        
        self.dataToLoad=dataToLoad
        self.dataLoaded = 0
        // self.view.isHidden=true
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
        
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.black
        overlay!.alpha = 0.8
        overlay!.addSubview(activityIndicator)
        view.addSubview(overlay!)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    
    func stopProgress()
    {
        dataLoaded = dataLoaded + 1
        if (dataToLoad == dataLoaded){
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            overlay?.removeFromSuperview()
        }
    }
    
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 250, height: 70))
        toastLabel.center = self.view.center
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 8.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
}
