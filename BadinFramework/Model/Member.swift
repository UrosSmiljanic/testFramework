//
//  Member.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import ObjectMapper

open class Member : Mappable {
    
    public var id                   : String?
    public var type                 : String?
    public var firstName            : String?
    public var lastName             : String?
    public var emailAddress         : String?
    public var birthDate            : String?
    public var loyaltyBalance       : String?
    public var creditBalance        : String?
    public var suburb               : String?
    public var physicalSuburb              : String?
    
    public var address1     : String?
    public var physicalAddress1     : String?
    
    public var    postcode : String?
    public var    city : String?
    
    public var    physicalPostcode : String?
    public var    physicalCity : String?
    
    public var enrolmentTrader      : String?
    public var enrolmentDate        : String?
    public var gender  : LookupField?
    public var mobileNumber : String?
    
    public var password:String?
    public var memberStatus:LookupField?
    
    public var cardNumber:String?
    public var cardPin:String?
    
     public init(cardNumber:String, password:String, email:String, firstName:String, lastName:String) {
        //        self.cardNumber = cardNumber
        //        self.password = password
        //        self.email = email
        //        self.firstName = firstName
        //        self.lastName = lastName
    }
    
    public required init?(map: Map) {
        
    }
    
    public required init?() {
        
    }
    
    open func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        emailAddress <- map["emailAddress"]
        birthDate <- map["birthDate"]
        loyaltyBalance <- map["loyaltyBalance"]
        creditBalance <- map["creditBalance"]
        suburb <- map["suburb"]
        physicalSuburb <- map["physicalSuburb"]
        physicalAddress1 <- map["physicalAddress1"]
        enrolmentTrader <- map["enrolmentTrader"]
        enrolmentDate <- map["enrolmentDate"]
        gender <- map["gender"]
        mobileNumber <- map["mobileNumber"]
        postcode <- map["postcode"]
        city <- map["city"]
        password <- map["password"]
        memberStatus <- map["memberStatus"]
        
        address1 <- map["address1"]
        physicalPostcode <- map["physicalPostcode"]
        physicalCity <- map["physicalCity"]
        cardPin <- map["cardPin"]
        cardNumber <- map["cardNumber"]
        
        
    }
}
