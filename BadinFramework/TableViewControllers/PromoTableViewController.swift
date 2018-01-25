//
//  PromoTableViewController.swift
//  genericappios
//
//  Created by DC on 05/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation

//
//  TransactionTableViewController.swift
//  genericappios
//
//  Created by DC on 01/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

protocol PromoTableViewControllerDelegate{
    func didSelectItem(dateIssued:String, dateExpire:String, name:String, desc:String)
    func isEmpty()
    func stopDelegateProgress()
}


class PromoTableViewController: UITableViewController {
    
    var delegate:PromoTableViewControllerDelegate! = nil
    
    var vouchers : VoucherListEmbedded?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ApiCalls.getVoucherAll(KeychainWrapper.standard.string(forKey: "userId")!,  success: handleSuccessfulVoucher, failure: handleFailedLogin)
        
    }
    
    func handleSuccessfulVoucher(_ voucherEmbedded: VoucherListEmbedded) {
        delegate.stopDelegateProgress()
        vouchers = voucherEmbedded
        self.tableView.reloadData()
        if  (vouchers!.voucherList == nil) || (vouchers?.voucherList?.vouchers?.count == 0){
            self.tableView.isHidden = true
            self.delegate.isEmpty()
        }
    }
    
    func handleFailedLogin(_ err: ErrorResponse) {
        delegate.stopDelegateProgress()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (vouchers == nil) {
            return 0}
        if (vouchers!.voucherList == nil) {
            return 0}
        return (vouchers!.voucherList?.vouchers?.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PromoViewCell
        let row = indexPath.row;  //  transEmbedded.transactionList?.transactions?[0].purchaseValue?.description
        
        cell.promoName.text = vouchers?.voucherList?.vouchers?[row].voucherName?.description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row;
        if let variableName = vouchers?.voucherList?.vouchers?[row].voucherDescription { // If casting, use, eg, if let var = abc as? NSString
            delegate.didSelectItem(dateIssued:TTLUtils.getDate(dateIn: (vouchers?.voucherList?.vouchers?[row].startDate)!), dateExpire: TTLUtils.getDate(dateIn: (vouchers?.voucherList?.vouchers?[row].endDate)!), name:  (vouchers?.voucherList?.vouchers?[row].voucherName)!, desc:   variableName)
            
        } else {
            delegate.didSelectItem(dateIssued:TTLUtils.getDate(dateIn: (vouchers?.voucherList?.vouchers?[row].startDate)!), dateExpire: TTLUtils.getDate(dateIn: (vouchers?.voucherList?.vouchers?[row].endDate)!), name:  (vouchers?.voucherList?.vouchers?[row].voucherName)!, desc:   "")
        }
        
        
    }
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
