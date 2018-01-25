//
//  TransactionViewController.swift
//  genericappios
//
//  Created by DC on 31/03/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

class TransactionViewController: BaseViewController,TransactionTableViewControllerDelegate  {
     override func viewDidLoad() {
        super.viewDidLoad()
        startProgress(dataToLoad: 1)
    }
    
    @IBOutlet weak var rightDrawer: UIView!
    @IBOutlet weak var emptyTrans: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func didSelectItem(date:String,store:String,value:String,transId:String) {
        transDetDate.text = date
        transDetStore.text = store
        transDetValue.text = value
        transDetId.text = transId
        
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
            let vc = segue.destination as! TransactionTableViewController
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
    @IBOutlet weak var transDetDate: UILabel!
    @IBOutlet weak var transDetStore: UILabel!
    @IBOutlet weak var transDetValue: UILabel!
    @IBOutlet weak var transDetId: UILabel!

    
}
