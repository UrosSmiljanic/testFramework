//
//  TransactionTableViewController.swift
//  genericappios
//
//  Created by DC on 01/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit

protocol TransactionTableViewControllerDelegate{
    func didSelectItem(date:String,store:String,value:String,transId:String)
    func isEmpty()
    func stopDelegateProgress()
}


class TransactionTableViewController: UITableViewController {
    
    var delegate:TransactionTableViewControllerDelegate! = nil
    
    var trans : TransactionListEmbedded?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
         tableView.estimatedRowHeight = 100
        ApiCalls.getTransAll(KeychainWrapper.standard.string(forKey: "userId")!,  success: handleSuccessfulTrans, failure: handleFailedLogin)
        
    }
    
    func handleSuccessfulTrans(_ transEmbedded: TransactionListEmbedded) {
        delegate.stopDelegateProgress()
        trans = transEmbedded
        self.tableView.reloadData()
        if trans?.transactionList?.transactions?.count == nil
        {
            self.tableView.isHidden = true
            delegate.isEmpty()
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
        if (trans == nil) {
            return 0}
        
        if (trans!.transactionList == nil) {
            return 0}
        return (trans!.transactionList?.transactions?.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransactionViewCell
        let row = indexPath.row;
        cell.transType.text = trans?.transactionList?.transactions?[row].transactionType?.value//purchaseValue?.description
        cell.transMerchant.text=trans?.transactionList?.transactions?[row].storeName
        cell.transDate.text=TTLUtils.getDate(dateIn: (trans?.transactionList?.transactions?[row].transactionDate)!)
        cell.transValue.text=trans?.transactionList?.transactions?[row].getValue()
        cell.transDetails.text=trans?.transactionList?.transactions?[row].detailsText()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row;
        delegate.didSelectItem(date: TTLUtils.getDate(dateIn: (trans?.transactionList?.transactions?[row].transactionDate)!), store: (trans?.transactionList?.transactions?[row].storeName)!,  value: (trans?.transactionList?.transactions?[row].getValue())!, transId: (trans?.transactionList?.transactions?[row].transactionId?.description)!)
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
