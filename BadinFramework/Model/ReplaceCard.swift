//
//  ReplaceCard.swift
//  genericappios
//
//  Created by DC on 13/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import ObjectMapper
import Foundation

open class ReplaceCard: Mappable {
/*   private String requestType;
 private String login;
 private String password;
 private String oldCardNumber;
 private String newCardNumber;
 private String flUpdate;
 private String programID;
*/

    open var requestType:String?
    open var login:String?
    open var password:String?
    open var oldCardNumber:String?
    open var newCardNumber:String?
    open var flUpdate:String?
    open var programID:String?

    
    public init() {
        
    }
    
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        requestType <- map["requestType"]
        login <- map["login"]
        password <- map["password"]
        oldCardNumber <- map["oldCardNumber"]
        newCardNumber <- map["newCardNumber"]
        flUpdate <- map["flUpdate"]
        programID <- map["programID"]

    }
}
