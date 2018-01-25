//
//  Token.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import 	ObjectMapper			

open class Token : Mappable{
    
    open var token:String = ""
    open var masterToken:String = ""
    open var expiration:AnyObject = "" as AnyObject
    open var userId:String = ""
    open var userName:String = ""
    open var userType:String = ""
    open var module:String = ""
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        token <- map["token"]
        masterToken <- map["masterToken"]
        expiration <- map["expiration"]
        userId <- map["userId"]
        userName <- map["userName"]
        userType <- map["userType"]
        module <- map["module"]
    }
}
