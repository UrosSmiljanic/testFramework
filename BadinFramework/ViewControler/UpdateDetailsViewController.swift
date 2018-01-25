//
//  UpdateDetailsViewController.swift
//  genericappios
//
//  Created by DC on 06/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import DropDown
import Firebase
import SwiftyJSON
import Alamofire
import ObjectMapper

class UpdateDetailsViewController: BaseViewController, UITextFieldDelegate{
    let genderDropDown = DropDown()
    let localStoreDropDown = DropDown()
    let milkDropDown = DropDown()
    let preferredDrinkDropDown = DropDown()
    var storesListM : StoremCardList!
    var storeList: Array<String> = Array()
    var storeDict: [String: String] = [:]
    var coffeeMilkTraderGroupList : CoffeeMilkTraderGroupList?
    var milkList : MilkList?
    var coffeeList : CoffeeList?
    var membershipId : String! = ""
    var unreg : Bool = false
    var initialMilk = ""
    var initialCoffe = ""
    @IBOutlet weak var viewS: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (unreg)
        {
            setBack()
            birthdate.isEnabled = true
            showDatePicker()
        }
            
        else {
            ApiCalls.getMember(  success: handleSuccessfulLogin, failure: handleFailedLogin)
            ApiCalls.getMemberships(KeychainWrapper.standard.string(forKey: "userId")!,token:KeychainWrapper.standard.string(forKey: "token")!,  success: handleSuccessfulMemberships, failure: handleFailedMemberships)
            startProgress(dataToLoad: 2)
        }
        // Do any additional setup after loading the view.
        gender.canEdit = false
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
        
        
        
        genderDropDown.anchorView = gender
        localStoreDropDown.anchorView = localstore
        milkDropDown.anchorView = milk
        preferredDrinkDropDown.anchorView = preferredDrink
        
        gender.delegate = self
        localstore.delegate = self
        milk.delegate = self
        preferredDrink.delegate = self
        postcode.delegate = self
        
        genderDropDown.bottomOffset = CGPoint(x: 0, y: gender.bounds.height)
        localStoreDropDown.bottomOffset = CGPoint(x: 0, y: localstore.bounds.height)
        milkDropDown.bottomOffset = CGPoint(x: 0, y: milk.bounds.height)
        preferredDrinkDropDown.bottomOffset = CGPoint(x: 0, y: preferredDrink.bounds.height)
        
        genderDropDown.dataSource = [
            "Male",
            "Female"
        ]
        
        genderDropDown.selectionAction = { [unowned self] (index, item) in
            self.gender.text = item
            
        }
        localStoreDropDown.selectionAction = { [unowned self] (index, item) in
            self.localstore.text = item
        }
        
        
        var remoteConfig: RemoteConfig!
        
        remoteConfig = RemoteConfig.remoteConfig()
        
        coffeeMilkTraderGroupList = CoffeeMilkTraderGroupList(JSONString: remoteConfig["traderGroups"].stringValue!)!
        
        milkList = MilkList(JSONString: remoteConfig["milk"].stringValue!)!
        
        milkDropDown.dataSource = (milkList?.getNames())!
        
        milkDropDown.selectionAction = { [unowned self] (index, item) in
            self.milk.text = item
        }
        
        coffeeList = CoffeeList(JSONString: remoteConfig["coffee"].stringValue!)!
        preferredDrinkDropDown.dataSource = (coffeeList?.getNames())!
        preferredDrinkDropDown.selectionAction = { [unowned self] (index, item) in
            self.preferredDrink.text = item
        }
        
        
        
        ApiCalls.getStores(success: successsStores, failure: failureStores)
        
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.topClickSelect (_:)))
        self.viewS.addGestureRecognizer(gesture)
        
        
        
    }
    
    
    
    @objc func topClickSelect(_ sender:UITapGestureRecognizer){
        var a:TextInputLayout!
        var min:Int = 10000
        for view in self.viewS.subviews   {
            do {
                if (view.frame.origin.y-sender.location(in: self.viewS).y)>0 && (Int(view.frame.origin.y-sender.location(in: self.viewS).y)) < min
                {
                    if view is TextInputLayout {
                        min = (Int(view.frame.origin.y-sender.location(in: self.viewS).y))
                        a = view as! TextInputLayout
                        
                    }
                    
                }
                
            }
        }
        if a != nil
        {
            _ = a.becomeFirstResponder()
        }
        
    }
    
    func successsStores(_ stores: StoremCardList) {
        
        self.storesListM = stores
        self.localStoreDropDown.dataSource  = self.storesListM.getStoresAll()
        self.localstore.text =  self.storesListM.getStoresName(id : localstore.text!)
        stopProgress()
    }
    func failureStores(_ err: ErrorResponse) {
        stopProgress()
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == postcode {
            
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == gender {
            genderDropDown.show()
            
            
            self.view.endEditing(true)
            return false
        }
        else if textField == milk {
            milkDropDown.show()
            
            
            self.view.endEditing(true)
            return false
        }
        else if textField == preferredDrink {
            preferredDrinkDropDown.show()
            
            
            self.view.endEditing(true)
            return false
        }
        else if textField == localstore {
            localStoreDropDown.show()
            
            
            self.view.endEditing(true)
            return false
        }
        else {return true}
        
    }
    
    @IBAction func genderDropDownAction(_ sender: Any) {
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        genderDropDown.show()
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        
    }
    @IBAction func milkDropDownAction(_ sender: Any) {
        milkDropDown.show()
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @IBAction func preferredCofeDropDownAction(_ sender: Any) {
        preferredDrinkDropDown.show()
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @IBAction func localStoreDropDownAction(_ sender: Any) {
        localStoreDropDown.show()
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    @IBOutlet weak var firstName: TextInputLayout!
    @IBOutlet weak var lastName: TextInputLayout!
    @IBOutlet weak var email: TextInputLayout!
    @IBOutlet weak var street: TextInputLayout!
    @IBOutlet weak var suburb: TextInputLayout!
    @IBOutlet weak var postcode: TextInputLayout!
    @IBOutlet weak var mobile: TextInputLayout!
    @IBOutlet weak var birthdate: TextInputLayout!
    @IBOutlet weak var gender: TextInputLayout!
    @IBOutlet weak var localstore: TextInputLayout!
    @IBOutlet weak var preferredDrink: TextInputLayout!
    @IBOutlet weak var milk: TextInputLayout!
    
    @IBOutlet weak var city: TextInputLayout!
    
    func handleSuccessfulLogin(_ member: Member) {
        
        firstName.text = member.firstName!
        lastName.text = member.lastName
        email.text = member.emailAddress
        street.text = member.physicalAddress1
        suburb.text = member.suburb
        postcode.text = member.postcode
        mobile.text = member.mobileNumber //
        if (member.birthDate != nil){
            birthdate.text = TTLUtils.getDate(dateIn: member.birthDate!)
            
        }
            
        else        {
            birthdate.isEnabled = true
            showDatePicker()
        }
        
        gender.text = member.gender?.value
        localstore.text = member.enrolmentTrader
        if (storesListM != nil){
            self.localstore.text =  self.storesListM.getStoresName(id : localstore.text!)
        }
        city.text = member.city
        stopProgress() 
    }
    
    
    @IBOutlet weak var aa: NSLayoutConstraint!
    @IBOutlet weak var scrollBottom: NSLayoutConstraint!
    
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.scrollBottom?.constant = 0.0
            } else {
                self.scrollBottom?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    @IBAction func updateDetails(_ sender: Any) {
        let member = Member()
        self.view.endEditing(true)
        
        var error =  false
        if ( firstName.text == "" )
        {  firstName.isError()
            error = true }
        
        if ( lastName.text == "" )
        {  lastName.isError()
            error = true }
        if ( email.text == "" )
        {  email.isError()
            error = true }
     
        if ( preferredDrink.text == "" )
        {  preferredDrink.isError()
            error = true }
        if ( milk.text == "" )
        {  milk.isError()
            error = true }
        if ( localstore.text == "" )
        {  localstore.isError()
            error = true }
      
        //birthdate
        if (!error){
            member?.firstName    = firstName.text
            member?.lastName    = lastName.text
            member?.emailAddress    = email.text
            member?.physicalAddress1    = street.text
            member?.address1    = street.text
            member?.physicalSuburb    = suburb.text
            member?.physicalPostcode    = postcode.text
            member?.suburb    = suburb.text
            member?.postcode    = postcode.text
            member?.mobileNumber     = mobile.text
            member?.city    = city.text
            member?.physicalCity    = city.text
           
            
            let gender = self.gender.text
            let genderLV = LookupField()
            if (gender == "Male"){
                genderLV?.id = "1"
                genderLV?.value = "Male"
                member?.gender    = genderLV
            }
                
            else
                if (gender == "Female"){
                    genderLV?.id = "2"
                    genderLV?.value = "Female"
                    member?.gender    = genderLV
            }
            
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyy-MM-dd"
            let birthDateS = formatter1.string(from: datePicker.date)+"T00:00:00Z"
            
            if (birthdate.isEnabled == true) {member?.birthDate     = birthDateS}
            
            
            member?.enrolmentTrader    =  self.storesListM.getStoresId(name : localstore.text!)
            startProgress(dataToLoad: 2)
            
            if (unreg){
                member?.password = KeychainWrapper.standard.string(forKey: "tempPass")!
                member?.cardPin = KeychainWrapper.standard.string(forKey: "tempPass")!
                member?.cardNumber = KeychainWrapper.standard.string(forKey: "tempCard")!
                
                
                ApiCalls.registerMember((member)!, success: successs, failure: handleFailedLogin)
            }
            else {  ApiCalls.updateDetails((member)!, success: successs, failure: handleFailedLogin)
            }
        }
    }
    
    func successs(_ err: Bool) {
        
        if ( self.membershipId == ""){
            let membershipGroup : MembershipGroup! = MembershipGroup()
            let groupId = LookupField()
            groupId?.id =  coffeeMilkTraderGroupList?.getGroupId(cofeeId: (coffeeList?.getId(name : self.preferredDrink.text!))!, milkId: (milkList?.getId(name : self.milk.text!))!)
            membershipGroup.membershipGroup = groupId
            membershipGroup.startDate = TTLUtils.getToday()
            membershipGroup.endDate = TTLUtils.getFutureToday()
            membershipGroup.member = KeychainWrapper.standard.string(forKey: "userId")!
            
            ApiCalls.createMemberships(membershipGroup, success: successsGroupCreate, failure: handleGroupCreate)
        }
        else
        {
            if (initialCoffe != self.preferredDrink.text!) || (initialMilk !=  self.milk.text!){
                let membershipGroup : MembershipGroup! = MembershipGroup()
                membershipGroup.id =  self.membershipId
                membershipGroup.endDate = TTLUtils.getToday()
                
                ApiCalls.updateMemberships(membershipGroup, success: successsGroupUpdate, failure: handleGroupUpdate)
            }
            else {
                showToast(message: "Member details updated successfully!" )
                stopProgress()
            }
        }
        stopProgress()
        
    }
    
    func handleFailedLogin(_ err: ErrorResponse) {
        stopProgress()
        stopProgress()
        
        showToast(message: err.userErrorMessage)
        
    }
    
    
    func successsGroupCreate(_ err: Bool) {
        showToast(message: "Member details updated successfully!" )
        
        stopProgress()
        
        if (unreg){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "balance") as! HomeScreenViewController
            //     self.navigationController!.viewControllers.removeAll()
            let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
            navigationController.pushViewController(nextViewController, animated: true)
            
        }
        
    }
    
    func handleGroupCreate(_ err: ErrorResponse) {
        stopProgress()
        showToast(message: err.userErrorMessage)
        
    }
    
    func successsGroupUpdate(_ err: Bool) {
        let membershipGroup : MembershipGroup! = MembershipGroup()
        let groupId = LookupField()
        groupId?.id =  coffeeMilkTraderGroupList?.getGroupId(cofeeId: (coffeeList?.getId(name : self.preferredDrink.text!))!, milkId: (milkList?.getId(name : self.milk.text!))!)
        membershipGroup.membershipGroup = groupId
        membershipGroup.startDate = TTLUtils.getToday()
        membershipGroup.endDate = TTLUtils.getFutureToday()
        membershipGroup.member = KeychainWrapper.standard.string(forKey: "userId")!
        ApiCalls.createMemberships(membershipGroup, success: successsGroupCreate, failure: handleGroupCreate)
    }
    
    func handleGroupUpdate(_ err: ErrorResponse) {
        stopProgress()
        showToast(message: err.userErrorMessage)
        
    }
    
    
    func handleSuccessfulMemberships(_ memberships: Membership) {
        if (memberships.memberships != nil){
            for mem in (memberships.memberships?.membership?.enumerated())!
            {
                for a in (coffeeMilkTraderGroupList?.coffeeMilkTraderGroup?.enumerated())!
                {
                    if mem.element.membershipGroup?.id == a.element.groupId
                    {
                        let date = Date()
                        
                        if (date.isBetweeen(date: TTLUtils.getDate(dateIn: mem.element.startDate!), andDate: TTLUtils.getDate(dateIn: mem.element.endDate!))) {
                            self.milk.text = milkList?.getName(id: a.element.milkId!)
                            initialMilk = self.milk.text!
                            self.preferredDrink.text = coffeeList?.getName(id: a.element.coffeeId!)
                            initialCoffe = self.preferredDrink.text!
                            self.membershipId = mem.element.id
                        }
                    }
                    
                }
            }
        }
        stopProgress()
        
    }
    
    func handleFailedMemberships(_ err: ErrorResponse) {
        stopProgress()
        //  showToast(message: "error")
        
    }
    
    /* ********** Date Picker For Birthday ********** */
    
    let datePicker = UIDatePicker()
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        
        //self.datePicker.maximumDate = Date()
        
        self.datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        self.datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -16, to: Date())
        
        // pickerView.datePicker.maximumDate=[NSDate date];
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor(red:1.00, green:0.81, blue:0.08, alpha:0.5)
        datePicker.backgroundColor = UIColor(red:1.00, green:0.81, blue:0.08, alpha:0.5)
        
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        
        birthdate.inputAccessoryView = toolbar
        birthdate.inputView = datePicker
        
        
        
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthdate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    /* ********** Date Picker For Birthday END ********** */
}
