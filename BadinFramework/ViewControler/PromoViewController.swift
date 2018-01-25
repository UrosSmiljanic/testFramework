//
//  TransactionViewController.swift
//  genericappios
//
//  Created by DC on 31/03/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class PromoViewController: BaseViewController,PromoTableViewControllerDelegate  {
    override func viewDidLoad() {
        super.viewDidLoad()
        startProgress(dataToLoad: 1)
        
    }
    @IBOutlet weak var rightDrawer: UIView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet var emptyTrans: UILabel!
    
    @IBOutlet weak var voucherName: UILabel!
    @IBOutlet weak var voucherDesc: UILabel!
    @IBOutlet weak var voucherIssued: UILabel!
    @IBOutlet weak var voucherExpires: UILabel!
    func didSelectItem(dateIssued:String, dateExpire:String, name:String, desc:String)
    {
        voucherDesc.text = desc
        voucherName.text = name
        voucherIssued.text = dateIssued
        voucherExpires.text = dateExpire
        UIView.animate(withDuration: 0.50, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            //Set x position what ever you want
            self.rightDrawer.frame = CGRect(x: self.view.bounds.size.width-200, y: 80, width: 200, height: self.view.bounds.size.height)
            
        }, completion: nil)
        rightDrawer.layer.shadowOpacity=0.5
    }
    
    func isEmpty() {
        emptyTrans.isHidden = false
    }
    
    func stopDelegateProgress() {
        stopProgress()
    }
    
    var menurightOpen=false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "table"{
            let vc = segue.destination as! PromoTableViewController
            vc.delegate = self
        }
    }
    
    @IBAction func closeSideMenu(_ sender: Any) {
        UIView.animate(withDuration: 0.50, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            //Set x position what ever you want
            self.rightDrawer.frame = CGRect(x: self.view.bounds.size.width, y: 80, width: 200, height: self.view.bounds.size.height)
            
        }, completion: nil)
        rightDrawer.layer.shadowOpacity=0
        menurightOpen = !menurightOpen
    }
    
    
}
