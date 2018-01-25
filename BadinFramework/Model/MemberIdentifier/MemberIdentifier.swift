//
//  MemberIdentifier.swift
//  genericappios
//
//  Created by DC on 03/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation

import ObjectMapper

open class MemberIdentifier : Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
       
    }

    
    
    public var memberIdentifier  : String?
    public var memberIdentifierType : LookupField?
    public var creationDate : String?
    public var startDate : String?
    public var endDate  : String?
    public var identifierStatus  : LookupField?
    public var currentPassword : String?
    public var newPassword  : String?
    public var currentPin : String?
    public var newPin : String?
    
    
    
    public required init?() {
        
    }
    
    
    open func mapping(map : Map){
        memberIdentifier <- map["memberIdentifier"]
        memberIdentifierType <- map["memberIdentifierType"]
        creationDate <- map["creationDate"]
        startDate <- map["startDate"]
        endDate <- map["endDate"]
        identifierStatus <- map["identifierStatus"]
        currentPassword <- map["currentPassword"]
        newPassword <- map["newPassword"]
        currentPin <- map["currentPin"]
        newPin <- map["newPin"]
    }
}
