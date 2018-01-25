//
//  MemberIdentifier.swift
//  genericappios
//
//  Created by DC on 03/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation

import ObjectMapper

open class Transaction : Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
    
    
    
    public var transactionId  : Int?
    public var parentTransactionId  : Int?
    public var transactionDate  : String?
    public var transactingCard  : String?
    public var storeName  : String?
    public var transactionType  : LookupField?
    public var transactionType1  : String?

    public var purchaseValue  : Float?
    public var loyaltyValue  : Int?
    public var creditValue  : Int?
    public var childTrans : EmbeddedChildTransactions?
    
    
    
    public required init?() {
        
    }
    
    
    open func mapping(map : Map){
        transactionId <- map["transactionId"]
        parentTransactionId <- map["parentTransactionId"]
        transactionDate <- map["date"]
        transactingCard <- map["transactingCard"]
        storeName <- map["storeName"]
        transactionType <- map["transactionType"]
        transactionType1 <- map["transactionType"]

        purchaseValue <- map["purchaseValue"]
        loyaltyValue <- map["loyaltyValue"]
        childTrans <- map["_embedded"]
        creditValue <- 	map["creditValue"]
     }
    
    func getTransactionText() -> String
    {
        return  (transactionType?.value)! + " at " + storeName! + " on " + (TTLUtils.getDate(dateIn: (transactionDate?.description)!))
        
    }
    
    open func getValue() -> String
    {
        if transactionType?.id == "1"
        {
            let formatter = NumberFormatter()
            formatter.locale = NSLocale.current  
            formatter.numberStyle = NumberFormatter.Style.decimal
            formatter.usesGroupingSeparator = true
            formatter.minimumFractionDigits = 2
            
              return "$"+formatter.string(from: purchaseValue! as NSNumber)!
        }
        if transactionType?.id == "2"
        {
            let formatter = NumberFormatter()
            formatter.locale = NSLocale.current
            formatter.numberStyle = NumberFormatter.Style.decimal
            formatter.usesGroupingSeparator = true
            formatter.minimumFractionDigits = 2
            
            return "$"+formatter.string(from: purchaseValue! as NSNumber)! + "\n" + (loyaltyValue?.description)!
        }
        
        return (loyaltyValue?.description)!
    }
    
    open func detailsText() -> String {
        var a = ""
        if childTrans != nil
        {
            if childTrans?.transactionList != nil
            {
                for trans in (childTrans?.transactionList?.enumerated())!
                {
                    
                    var d = ""
                    if trans.element.loyaltyValue!  > 0
                    {
                        d = "Points Earned"
                    }
                    else
                    {
                        d = "Points Redeemed"
                    }
                    a = a + newLine(a:a) + d + "\n" + String(trans.element.loyaltyValue!)
                    
                }
            }
            
            if childTrans?.voucherList != nil
                
            { for voucher in (childTrans?.voucherList?.enumerated())!{
                let d = "Voucher Redeemed"
                
                a = a + newLine(a:a) + d + "\n" + voucher.element.voucherName!
                
                }
            }
            

        }
         
        
        return a
    }
    
    func newLine(a : String) -> String {
        if a == "" {return ""}
        else {return "\n"}
    }
    
}
