//
//  RegisterViewController.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
//import DatePickerDialog
import SwiftyJSON
//import DropDown

class RegisterViewController : BaseViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    
    // @IBOutlet weak var cardNumberField: ValidatedInputFieldView!
    //@IBOutlet weak var pinField: ValidatedInputFieldView!
    
    @IBOutlet weak var selectGenderLabel: TextInputLayout!
    @IBOutlet weak var selectIslandLabel: TextInputLayout!
    @IBOutlet weak var selectRegionLabel: TextInputLayout!
    @IBOutlet weak var selectStoreLabel:  TextInputLayout!
    
    @IBOutlet weak var selectBirthDateLabel: TextInputLayout!
    @IBOutlet weak var emailField: TextInputLayout!
    @IBOutlet var passwordField: TextInputLayout!
    @IBOutlet weak var firstNameField: TextInputLayout!
    @IBOutlet weak var lastNameField: TextInputLayout!
    @IBOutlet var mobileField: TextInputLayout!
    
    //  let islandList = ["North Island", "South Island"]
    var regionList: Array<String> = Array()
    var storeList: Array<String> = Array()
    @IBAction func selectBirthDay(_ sender: Any) {
    }
    var storeDict: [String: String] = [:]
    
    var storeId: String!
    var birthDate:String!
    
    var storesListM : StoremCardList!
    var activeIsland : String!
    var activeRegion : String!
    var activeStore : String!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setBack()
        showDatePicker()
        
        
        ApiCalls.getStores(success: successsStores, failure: failureStores)
        
        disableKeyboard()
        pickerViewForbidden ()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.topClickSelect (_:)))
        self.viewConteiner.addGestureRecognizer(gesture)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
    }
    
    @objc func topClickSelect(_ sender:UITapGestureRecognizer){
        var a:TextInputLayout!
        var min:Int = 10000
        for view in self.viewConteiner.subviews   {
            do {
                if (view.frame.origin.y-sender.location(in: self.viewConteiner).y)>0 && (Int(view.frame.origin.y-sender.location(in: self.viewConteiner).y)) < min
                {
                    if view is TextInputLayout {
                        min = (Int(view.frame.origin.y-sender.location(in: self.viewConteiner).y))
                        a = view as! TextInputLayout
                        
                    }
                    
                }
                
            }
        }
        if a != nil
        {
            _ = a.becomeFirstResponder()
        }
        
    }//self.mapMaybe.frame.origin.y
    
    func successsStores(_ stores: StoremCardList) {
        
        self.storesListM = stores
        stopProgress()
    }
    func failureStores(_ err: ErrorResponse) {
        stopProgress()
        
    }
    func pickerViewForbidden (){
        
        
        if self.selectIslandLabel.text != "" {
            
            self.selectRegionLabel.isUserInteractionEnabled = true
            
        }else{
            self.selectRegionLabel.isUserInteractionEnabled = false
        }
        if self.selectRegionLabel.text != "" {
            
            self.selectStoreLabel.isUserInteractionEnabled = true
            
        }else{
            self.selectStoreLabel.isUserInteractionEnabled = false
        }
        
        
    }
    
    
    
    @IBAction func registerBtn(_ sender: Any) {
        /*view.endEditing(true)
         performSegue(withIdentifier: "RegisterSuccesfull", sender: self)*/
        
        
        dismissKeyboard()
        var error =  false
        let memberDetails = Member()
        
        if ( firstNameField.text == "" )
        {  firstNameField.isError()
            error = true }
        
        if ( lastNameField.text == "" )
        {  lastNameField.isError()
            error = true }
        
        
        if ( emailField.text == "" )
        {  emailField.isError()
            error = true }
        
        
        
        if ( passwordField.text == "" )
        {  passwordField.isError()
            error = true }
        
        
        
        if ( mobileField.text == "" )
        {  mobileField.isError()
            error = true }
        
        
        if ( lastNameField.text == "" )
        {  lastNameField.isError()
            error = true }
        //
        //        if ( selectBirthDateLabel.text == "" )
        //        {  selectBirthDateLabel.isError()
        //            error = true }
        //
        //        if ( selectGenderLabel.text == "" )
        //        {  selectGenderLabel.isError()
        //            error = true }
        //
        
        if ( selectIslandLabel.text == "" )
        {  selectIslandLabel.isError()
            error = true }
        
        
        
        if ( selectRegionLabel.text == "" )
        {  selectRegionLabel.isError()
            error = true }
        
        
        
        if ( selectStoreLabel.text == "" )
        {  selectStoreLabel.isError()
            error = true }
        
        
        
        if error == false {
            memberDetails?.firstName    = firstNameField.text
            memberDetails?.lastName    = lastNameField.text
            memberDetails?.emailAddress    = emailField.text
            memberDetails?.password    = passwordField.text
            memberDetails?.mobileNumber    = mobileField.text
            
            
            
            if (selectBirthDateLabel.text != ""){
                let formatter1 = DateFormatter()
                formatter1.dateFormat = "yyyy-MM-dd"
                self.birthDate = formatter1.string(from: datePicker.date)+"T00:00:00Z"
                
                memberDetails?.birthDate     = birthDate}
            let gender = selectGenderLabel.text
            let genderLV = LookupField()
            if (gender == "Male"){
                genderLV?.id = "1"
                genderLV?.value = "Male"
                memberDetails?.gender    = genderLV
            }
                
            else
                if (gender == "Female"){
                    genderLV?.id = "2"
                    genderLV?.value = "Female"
                    memberDetails?.gender    = genderLV
            }
            
            //let storeName = selectStoreLabel.titleLabel?.text
            memberDetails?.enrolmentTrader    = activeStore
            
            
            startProgress(dataToLoad: 1)
            ApiCalls.registerMember((memberDetails)!, success: successs, failure: handlefailed)
        }
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        
        selectBirthDateLabel.inputAccessoryView = toolbar
        selectBirthDateLabel.inputView = datePicker
        
        
        
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        selectBirthDateLabel.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    /* ********** Date Picker For Birthday END ********** */
    
    /* ********** Gender and Island Picker ********** */
    
    // content for pickerViews
    let gender = ["Male" , "Female"]
    let island = ["South Island" , "North Island"]
    
    
    // variables to gold current data
    var picker : UIPickerView!
    var activeTextField = 0
    var activeTF : UITextField!
    var activeValue = ""
    
    var activeArray : Array<Any>!
    
    
    // delegates for text fields
    //    selectGenderLabel.delegate = self
    //  selectIslandLabel.delegate = self
    
    
    
    // number of components in picekr view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // return number of elements in picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // get number of elements in each pickerview
        switch activeTextField {
        case 1:
            return gender.count
        case 2:
            return island.count
        case 3:
            return storesListM.getRegionsFilter(parentId: activeIsland).count
        case 4:
            return  storesListM.getStoresFilter(groupId: activeRegion).count
        default:
            return 0
        }
    }
    
    // return "content" for picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // return correct content for picekr view
        switch activeTextField {
        case 1:
            return gender[row]
        case 2:
            return island[row]
        case 3:
            return storesListM.getRegionsFilter(parentId: activeIsland)[row]
        case 4:
            return  storesListM.getStoresFilter(groupId: activeRegion)[row]
        default:
            return ""
        }
        
    }
    
    // get currect value for picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // set currect active value based on picker view
        switch activeTextField {
        case 1:
            activeValue = gender[row]
        case 2:
            activeValue = island[row]
        case 3:
            activeValue = storesListM.getRegionsFilter(parentId: activeIsland)[row]
        case 4:
            activeValue =  storesListM.getStoresFilter(groupId: activeRegion)[row]
        default:
            activeValue = ""
        }
    }
    
    // start editing text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // set up correct active textField (no)
        switch textField {
        case selectGenderLabel:
            activeTextField = 1
        case selectIslandLabel:
            activeTextField = 2
        case selectRegionLabel:
            activeTextField = 3
        case selectStoreLabel:
            activeTextField = 4
        default:
            activeTextField = 0
        }
        
        // set active Text Field
        activeTF = textField
        
        self.pickUpValue(textField: textField)
        
    }
    
    // show picker view
    func pickUpValue(textField: UITextField) {
        
        
        
        
        // create frame and size of picker view
        picker = UIPickerView(frame:CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: 216)))
        
        // deletates
        picker.delegate = self
        picker.dataSource = self
        
        // if there is a value in current text field, try to find it existing list
        if let currentValue = textField.text {
            
            var row : Int?
            
            // look in correct array
            switch activeTextField {
            case 1:
                row = gender.index(of: currentValue)
            case 2:
                row = island.index(of: currentValue)
            case 3:
                row = storesListM.getRegionsFilter(parentId: activeIsland).index(of: currentValue)
            case 4:
                row =  storesListM.getStoresFilter(groupId: activeRegion).index(of: currentValue)
            default:
                row = nil
            }
            
            // we got it, let's set select it
            if row != nil {
                picker.selectRow(row!, inComponent: 0, animated: true)
            }
        }
        
        
        
        
        picker.backgroundColor = UIColor(red:1.00, green:0.81, blue:0.08, alpha:0.5)
        textField.inputView = self.picker
        
        // toolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor(red:1.00, green:0.81, blue:0.08, alpha:0.5)
        toolBar.sizeToFit()
        
        // buttons for toolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([doneButton, spaceButton, cancelButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    // done
    @objc func doneClick() {
        switch activeTextField {
        case 1:
            activeTF.text = gender[picker.selectedRow(inComponent: 0)]
        case 2:
            activeTF.text = island[picker.selectedRow(inComponent: 0)]
            if (island[picker.selectedRow(inComponent: 0)].contains("North")) {
                if (activeIsland != "129") {
                    activeIsland = "129"
                    selectRegionLabel.text = ""
                    selectStoreLabel.text = ""
                    activeRegion = ""
                    activeStore = ""
                }
            }
            else {
                if (activeIsland != "130") {
                    activeIsland = "130"
                    selectRegionLabel.text = ""
                    selectStoreLabel.text = ""
                    
                    activeRegion = ""
                    activeStore = ""
                }
                
            }
        case 3:
            activeTF.text = storesListM.getRegionsFilter(parentId: activeIsland)[picker.selectedRow(inComponent: 0)]
            if (activeRegion != storesListM.getRegionIdFilter(parentId: activeIsland)[picker.selectedRow(inComponent: 0)]){
                activeRegion = storesListM.getRegionIdFilter(parentId: activeIsland)[picker.selectedRow(inComponent: 0)]
                selectStoreLabel.text = ""
                activeStore = ""
                
            }
        case 4:
            activeTF.text = storesListM.getStoresFilter(groupId: activeRegion)[picker.selectedRow(inComponent: 0)]
            activeStore = storesListM.getStoresIdFilter(groupId: activeRegion)[picker.selectedRow(inComponent: 0)]
            
            
        default:
            activeTF.text = ""
        }
        
        
        pickerViewForbidden ()
        
        activeTF.resignFirstResponder()
        
    }
    
    // cancel
    @objc func cancelClick() {
        activeTF.resignFirstResponder()
    }
    
    
    /* ********** Gender and Island Picker END ********** */
    
    
    
    
    /*  @IBAction func selectGenderAction(_ sender: TextInputLayout) {
     dismissKeyboard()
     selectGenderDropDown.show()
     }
     
     @IBAction func selectIslandAction(_ sender: TextInputLayout) {
     dismissKeyboard()
     selectIslandDropDown.show()
     }
     */
    
    /*   @IBAction func selectRegionAction(_ sender: TextInputLayout) {
     dismissKeyboard()
     selectRegionDropDown.show()
     }
     */
    /*  @IBAction func selectStoreAction(_ sender: TextInputLayout) {
     dismissKeyboard()
     selectStoreDropDown.show()
     }
     */
    /*@IBAction func pickBirthdateBtn(_ sender: Any) {
     DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", datePickerMode: .date) {
     (date) -> Void in
     if let dt = date {
     let formatter = DateFormatter()
     formatter.dateFormat = "dd/MM/yyyy"
     let formatter1 = DateFormatter()
     formatter1.dateFormat = "yyyy-MM-dd"
     self.birthDate = formatter1.string(from: dt)+"T00:00:00Z"
     //self.birthDateLabel.setTitle(formatter.string(from: dt), for: .normal)
     }
     }
     }*/
    
    @IBAction func backAction(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*
     fileprivate func getParentView(_ view: UIView) -> ValidatedInputFieldView {
     let myView = view.superview
     if(myView is ValidatedInputFieldView) {
     return myView as! ValidatedInputFieldView
     }
     else {
     return getParentView(myView!)
     }
     }
     
     */
    
    //Calls this function when the tap is recognized.
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        self.resignFirstResponder()
    }
    
    func successs(_ err: Bool) {
        
        stopProgress()
        
        KeychainWrapper.standard.set(passwordField.text!, forKey: "tempPassR")
        KeychainWrapper.standard.set(emailField.text!, forKey: "tempCardR")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "regsuc") 
        self.navigationController?.pushViewController(nextViewController, animated:false )
        
        
    }
    
    func handlefailed(_ err: ErrorResponse) {
        stopProgress()
        showToast(message: err.userErrorMessage)
        
    }
    
    func disableKeyboard() {
        let dummyView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        self.selectGenderLabel.inputView = dummyView
        self.selectIslandLabel.inputView = dummyView
        self.selectRegionLabel.inputView = dummyView
        self.selectStoreLabel.inputView  = dummyView
    }
    
    func setupDropDown() {
        //      selectGenderDropDown.anchorView = selectGenderLabel
        //     selectIslandDropDown.anchorView = selectIslandLabel
        //    selectRegionDropDown.anchorView = selectRegionLabel
        //   selectStoreDropDown.anchorView  = selectStoreLabel
        
        //   selectGenderDropDown.dataSource = ["Male", "Female"]
        //   selectIslandDropDown.dataSource = ["North Island", "South Island"]
    }
    
    func setupDropDownSelectActions() {
        /*          selectGenderDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
         self.selectGenderLabel.text = item
         }
         */
        
        //selectIslandDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        //self.selectIslandLabel.text = item
        
        if self.selectRegionLabel.isUserInteractionEnabled == false {
            self.selectRegionLabel.isUserInteractionEnabled = true
        } else {
            self.selectRegionLabel.text = ""
        }
        
        if self.selectStoreLabel.text != "" {
            self.selectStoreLabel.text = ""
            if self.selectStoreLabel.isUserInteractionEnabled == true {
                self.selectStoreLabel.isUserInteractionEnabled = false
            }
        }
        //}
        
        /*    selectRegionDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
         self.selectRegionLabel.text = item
         self.selectStoreLabel.isUserInteractionEnabled = true
         }
         
         
         selectStoreDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
         self.selectStoreLabel.text = item
         }
         */
    }
    
    // using default function for keyboard dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewConteiner: UIView!
    
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
                self.scrollBottom?.constant = (endFrame?.size.height) ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}


