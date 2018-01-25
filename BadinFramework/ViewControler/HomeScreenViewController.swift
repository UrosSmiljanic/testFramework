//
//  HomeScreenViewController.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import Foundation
import QRCode
import Firebase
import ObjectMapper
import SwiftLocation
import CoreLocation
import MapKit
import FacebookCore


class HomeScreenViewController: BaseViewController , UIScrollViewDelegate, ProgressBarDelegate{
    func refresh(balance: String) {
        qrCodeView.rewardsBalance.text="Rewards Balance "+balance 
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var promoWeb: UIWebView!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var nearestStore: ShortInfoView!
    
    
    @IBOutlet weak var promoView: ShortInfoView!
    var qrCodeView:QRCodeView!
    var userDataView:UserDataView!
    var progressBar:ProgressBarView!
    var storeList:StoreList!
    
    var remoteConfig: RemoteConfig!
    
    var ref: DatabaseReference!
    
    var distanceMin = 4000000000.00
    var ind = 0
    var locationL:CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppEventsLogger.log("HomeScreenOpened")
        
        
        if (self.navigationController != nil)
        {    var navArray:Array =   (self.navigationController?.viewControllers)!
            while navArray.count > 1 {
                navArray.remove(at: navArray.count-2)
                    .navigationController?.viewControllers = navArray
            }
        }
        else {
            
        }
        
        
        let scrollViewWidth:CGFloat = self.view.frame.width-30
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        
        qrCodeView = QRCodeView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        
        progressBar = ProgressBarView (frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        
        userDataView = UserDataView (frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        
        progressBar.delegate =  self
        
        self.scrollView.addSubview(qrCodeView)
        self.scrollView.addSubview(userDataView)
        self.scrollView.addSubview(progressBar)
        
        
        
        self.scrollView.contentSize = CGSize(width:scrollViewWidth * 3, height:self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        
        self.mainScrollView.contentSize = CGSize(width:self.mainScrollView.frame.width * 2  , height:self.mainScrollView.frame.height * 2)
        
        
        mainScrollView.isScrollEnabled = true
        
        promoView.title.text = "Promos"
        
        
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "userName")
        userDataView.cardNumber.text = retrievedString
        
        ApiCalls.getMember(  success: handleSuccessfulLogin, failure: handleFailedLogin)
        
        
        ApiCalls.getIdents(KeychainWrapper.standard.string(forKey: "userId")!,token:KeychainWrapper.standard.string(forKey: "token")!,  success: handleSuccessfulLoginIdent, failure: handleFailedLogin)
        
        ApiCalls.getTransSingle(KeychainWrapper.standard.string(forKey: "userId")!,token:KeychainWrapper.standard.string(forKey: "token")!,  success: handleSuccessfulTrans, failure: handleFailedLogin)
        
        
        ApiCalls.getVoucherSingle(KeychainWrapper.standard.string(forKey: "userId")!,  success: handleSuccessfulVoucher, failure: handleFailedLogin)
        
        startProgress(dataToLoad: 4)
        
        // lastTransaction.addTarget(self, action: #selector(goToTrans), for: .touchDown)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (goToTrans (_:)))
        lastTransaction.addGestureRecognizer(gesture)
        
        let gesture1 = UITapGestureRecognizer(target: self, action:  #selector (goToStores (_:)))
        nearestStore.addGestureRecognizer(gesture1)
        
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (goToPromo (_:)))
        promoView.addGestureRecognizer(gesture2)
        
        
        remoteConfig = RemoteConfig.remoteConfig()
        let remoteConfigSettings = RemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = remoteConfigSettings!
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        // [END set_default_values]
        
        
        remoteConfig.fetch(withExpirationDuration: TimeInterval(10)) { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activateFetched()
            } else {
                print("Config not fetched")
           //     print("Error \(error!.localizedDescription)")
            }
            self.storeList = StoreList(JSONString: self.remoteConfig["store_locations"].stringValue!)!
            if self.locationL != nil
                
            {
                for (index, loc) in self.storeList.getCLocations().enumerated()   {
                    let distanceInMeters = loc.distance(from: self.locationL) // result is in meters
                    if self.distanceMin > distanceInMeters
                    { self.distanceMin = distanceInMeters
                        self.ind = index
                    }
                }
                
                self.nearestStore.topText.text = self.storeList.storeList?[self.ind].storeName
                let df = MKDistanceFormatter()
                df.unitStyle = .abbreviated
                
                self.nearestStore.bottomText.text = df.string(fromDistance: self.distanceMin)
                
            }
            
        }
        
        
        ref = Database.database().reference()
        
        nearestStore.topText.text = "Enable location to see nearest store"
        nearestStore.bottomText.text = ""
        if (KeychainWrapper.standard.string(forKey: "notification_token") != nil)
        {  self.ref.child("ios_token").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(KeychainWrapper.standard.string(forKey: "notification_token")!);
        }
        /*
        Locator.currentLocation(accuracy: .city, frequency: .oneShot, success: { (_, location) in
            print("A new update of location is available: \(location)")
            //  self.ref.child("users").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(["username": location.description])
            self.ref.child("ios_user_locations").child(KeychainWrapper.standard.string(forKey: "userId")!).child(self.Timestamp).setValue(location.description);
            self.locationL = location
            //  self.nearestStore.bottomText.text = location.description
            //let distanceInMeters = coordinate₀.distance(from: coordinate₁) // result is in meters
            if self.storeList != nil
            {
                for (index, loc) in self.storeList.getCLocations().enumerated()   {
                    let distanceInMeters = loc.distance(from: location) // result is in meters
                    if self.distanceMin > distanceInMeters
                    { self.distanceMin = distanceInMeters
                        self.ind = index
                    }
                }
                
                self.nearestStore.topText.text = self.storeList.storeList?[self.ind].storeName
                let df = MKDistanceFormatter()
                df.unitStyle = .abbreviated
                
                self.nearestStore.bottomText.text = df.string(fromDistance: self.distanceMin)            }
            
        }) { (request, last, error) in
            request.cancel() // stop continous location monitoring on error
            print("Location monitoring failed due to an error \(error)")
        }
        */
        
        
        
        
        
        
    }
    
    var Timestamp: String {
        let s=Int64(floor((NSDate().timeIntervalSince1970 * 1000)))
        return s.description
    }
    
    //MARK: UIScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        
    }
    
    //TODO ADD page controll select
    
    
    func handleSuccessfulLogin(_ member: Member) {
        
        qrCodeView.rewardsBalance.text="Rewards Balance "+member.loyaltyBalance!
        userDataView.userType.text = member.type
        userDataView.userName.text = member.firstName! + " " + member.lastName!
        if (member.enrolmentDate != nil) {
            userDataView.memberSince.text = TTLUtils.getDate(dateIn : member.enrolmentDate!)
        }
        guard let n = NumberFormatter().number(from: member.loyaltyBalance!) else { return }
        
        progressBar.balance =  CGFloat(truncating: n)
        
        progressBar.userName.text =  member.firstName! + " " + member.lastName!
        
        stopProgress()
        
        
        
    }
    
    
    func handleSuccessfulLoginIdent(_ memberIdents: MemberIdentifierListEmbedded) {
        if (memberIdents.memberIdents != nil){
            for mem in (memberIdents.memberIdents?.memberIdents?.enumerated())!
            {
                
                let date = Date()
                
                if (date.isLess(date: TTLUtils.getDate(dateIn: mem.element.endDate!)))&&(mem.element.identifierStatus?.id=="1")&&(mem.element.identifierStatus?.id=="1")&&(mem.element.memberIdentifierType?.id=="1")
                {
                    
                    
                    qrCodeView.loadQrCard(card:  (mem.element.memberIdentifier)!)
                    qrCodeView.cardNumber.text = mem.element.memberIdentifier
                    userDataView.cardNumber.text = mem.element.memberIdentifier
                    
                    KeychainWrapper.standard.set((mem.element.memberIdentifier)!, forKey: "cardNumber")
                    
                }
                
                
            }
        }
        
        stopProgress()
        
        
        
    }
    
    
    
    func handleFailedLogin(_ err: ErrorResponse) {
        stopProgress()
        
    }
    
    @IBOutlet weak var lastTransaction: LastTransactionView!
    
    func handleSuccessfulTrans(_ transEmbedded: TransactionListEmbedded) {
        
        
        let count = transEmbedded.transactionList?.transactions?.count
        
        if (count == nil)||(count == 0) {
            //   promoView.frame.height = 0
            
            lastTransaction.isHidden = true
            
        }
        else
        {
            lastTransaction.title.text = "Last Transaction"
            lastTransaction.value.text = (  transEmbedded.transactionList?.transactions?[0].getValue())!
            lastTransaction.text.text = transEmbedded.transactionList?.transactions?[0].getTransactionText()
        }
        
        
        stopProgress()
        
        
        
    }
    
    
    func handleSuccessfulVoucher(_ vouchermbedded: VoucherListEmbedded) {
        
        promoView.title.text = "Promos"
        
        let count = vouchermbedded.voucherList?.vouchers?.count
        if (count == nil)||(count == 0) {
            //   promoView.frame.height = 0
            
            promoView.isHidden = true
            
        }
        else
        {
            promoView.bottomText.text = ""
            promoView.topText.text = vouchermbedded.voucherList?.vouchers?[0].voucherName
        }
        
        
        stopProgress()
        
        
        
    }
    
    @objc func goToTrans(_ sender:UITapGestureRecognizer){
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "transactions") as! TransactionViewController
        self.navigationController?.pushViewController(nextViewController, animated:false )
        
        
    }
    
    @objc func goToStores(_ sender:UITapGestureRecognizer){
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "storeList") as! StoreViewController
        self.navigationController?.pushViewController(nextViewController, animated:false )
        
        
    }
    
    @objc func goToPromo(_ sender:UITapGestureRecognizer){
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "promo") as! PromoViewController
        self.navigationController?.pushViewController(nextViewController, animated:false )
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressBar.reset()
    }
    
    
   
    
    
}
