//
//  MemberIdentifier.swift
//  genericappios
//
//  Created by DC on 03/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation

import ObjectMapper

open class Voucher : Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
    
    
    public var id : Int?
    public var traderId : Int?
    public var voucherCode : String?
    public var voucherName : String?
    public var startDate : String?
    public var endDate : String?
    public var dateRedeemed : String?
    public var status : LookupField?
    public var transactionId : String?
    public var voucherTenderId : Int?
    public var redemptionsAllowed : Int?
    public var redemptionHistory : String?
    public var voucherValue : Int?
    public var voucherType : String?
    public var campaign : String?
    public var voucherDescription : String?
    public var voucherImage : String?
    
    
    
    public required init?() {
        
    }
    
    
    open func mapping(map : Map){
        id <- map["id"]
        traderId <- map["traderId"]
        voucherCode <- map["voucherCode"]
        voucherName <- map["voucherName"]
        startDate <- map["startDate"]
        endDate <- map["endDate"]
        dateRedeemed <- map["dateRedeemed"]
        status <- map["status"]
        transactionId <- map["transactionId"]
        voucherTenderId <- map["voucherTenderId"]
        redemptionsAllowed <- map["redemptionsAllowed"]
        redemptionHistory <- map["redemptionHistory"]
        voucherValue <- map["voucherValue"]
        voucherType <- map["voucherType"]
        campaign <- map["campaign"]
        voucherDescription <- map["voucherDescription"]
        voucherImage <- map["voucherImage"]
    }
    
    func getTransactionText() -> String
    {
       return  "" //(transactionType?.value)! + " at" + storeName! + " on " + (transactionDate?.description)!
        
    }
    
}
