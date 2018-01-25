//
//  AppSettingsViewController.swift
//  genericappios
//
//  Created by DC on 10/10/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import CoreLocation
import UserNotifications
import FirebaseMessaging

class AppSettingsViewController: BaseViewController, UNUserNotificationCenterDelegate {
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        ref = Database.database().reference()
        
        if (  KeychainWrapper.standard.bool(forKey: "location") == nil )
        {
            if CLLocationManager.locationServicesEnabled() {
                switch(CLLocationManager.authorizationStatus()) {
                case .notDetermined, .restricted, .denied:
                    KeychainWrapper.standard.set(false, forKey: "location")
                    location.setOn(false, animated: false)
                    self.ref.child("ios_location_opt").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.bool(forKey: "location")!);
                    
                case .authorizedAlways, .authorizedWhenInUse:
                    KeychainWrapper.standard.set(true, forKey: "location")
                    location.setOn(true, animated: false)
                    self.ref.child("ios_location_opt").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.bool(forKey: "location")!);
                    
                    
                }
            } else {
                location.setOn(false, animated: false)
            }
            
        }
        else {
            
            location.setOn(KeychainWrapper.standard.bool(forKey: "location")!, animated: false)
            
        }
        
        
        if (  KeychainWrapper.standard.bool(forKey: "notification") == nil )
        {
            let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
            if isRegisteredForRemoteNotifications {
                KeychainWrapper.standard.set(true, forKey: "notification")
                self.ref.child("ios_notification_opt").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.bool(forKey: "notification")!);
                
                notification.setOn(true, animated: false)
            } else {
                KeychainWrapper.standard.set(false, forKey: "notification")
                self.ref.child("ios_notification_opt").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.bool(forKey: "notification")!);
                
                notification.setOn(false, animated: false)
            }
        }
        else {
            
            notification.setOn(KeychainWrapper.standard.bool(forKey: "notification")!, animated: false)
            
        }
        
        if (  KeychainWrapper.standard.bool(forKey: "promoNotification") == nil )
        {
            let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
            if isRegisteredForRemoteNotifications {
                KeychainWrapper.standard.set(true, forKey: "promoNotification")
                self.ref.child("ios_promo_notification_opt").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.bool(forKey: "promoNotification")!);
                
                
                promoNotification.setOn(true, animated: false)
            } else {
                KeychainWrapper.standard.set(false, forKey: "promoNotification")
                self.ref.child("ios_promo_notification_opt").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.bool(forKey: "promoNotification")!);
                
                promoNotification.setOn(false, animated: false)
            }
        }
        else {
            
            promoNotification.setOn(KeychainWrapper.standard.bool(forKey: "promoNotification")!, animated: false)
            
        }
        
        if (  KeychainWrapper.standard.bool(forKey: "nearStore") == nil )
        {
            let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
            if isRegisteredForRemoteNotifications {
                KeychainWrapper.standard.set(true, forKey: "nearStore")
                self.ref.child("ios_near_store").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.bool(forKey: "nearStore")!);
                
                
                nearStore.setOn(true, animated: false)
            } else {
                KeychainWrapper.standard.set(false, forKey: "nearStore")
                self.ref.child("ios_near_store").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.bool(forKey: "nearStore")!);
                
                nearStore.setOn(false, animated: false)
            }
        }
        else {
            
            nearStore.setOn(KeychainWrapper.standard.bool(forKey: "nearStore")!, animated: false)
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*if CLLocationManager.locationServicesEnabled() {
     switch(CLLocationManager.authorizationStatus()) {
     case .notDetermined, .restricted, .denied:
     print("No access")
     case .authorizedAlways, .authorizedWhenInUse:
     print("Access")
     }
     } else {
     print("Location services are not enabled")
     }
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBOutlet weak var notification: UISwitch!
    @IBOutlet weak var promoNotification: UISwitch!
    @IBOutlet weak var nearStore: UISwitch!
    @IBOutlet weak var location: UISwitch!
    
    @IBAction func notificationAction(_ sender: Any) {
        KeychainWrapper.standard.set(notification.isOn, forKey: "notification")
        self.ref.child("ios_notification_opt").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.bool(forKey: "notification")!);
        if (notification.isOn){
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().delegate = self
                
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: {_, _ in })
            } else {
                let settings: UIUserNotificationSettings =
                    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(settings)
            }
            
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    @IBAction func promoNotificationAction(_ sender: Any) {
        KeychainWrapper.standard.set( promoNotification.isOn, forKey: "promoNotification")
        self.ref.child("ios_promo_notification_opt").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.bool(forKey: "promoNotification")!);
        
        if (promoNotification.isOn){
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().delegate = self
                
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: {_, _ in })
            } else {
                let settings: UIUserNotificationSettings =
                    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(settings)
            }
            
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    @IBAction func nearStoreNotifationAction(_ sender: Any) {
        KeychainWrapper.standard.set(nearStore.isOn, forKey: "nearStore")
        self.ref.child("ios_near_store").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.bool(forKey: "nearStore")!);
        if (nearStore.isOn){
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().delegate = self
                
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: {_, _ in })
            } else {
                let settings: UIUserNotificationSettings =
                    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(settings)
            }
            
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    @IBAction func locationAction(_ sender: Any) {
        KeychainWrapper.standard.set(location.isOn, forKey: "location")
        self.ref.child("ios_location_opt").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.bool(forKey: "location")!);
        
    }
    
}
