//
//  Login.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import ObjectMapper

open class Login : Mappable {
    
    open var username:String?
    open var password:String?
    open var masterToken:String?
    
    
    public init(uname:String, pass:String) {
        username = uname
        password = pass
    }
    
    public init(masterToken :String) {
        self.masterToken = masterToken
    }
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        username <- map["username"]
        password <- map["password"]
        masterToken <- map["masterToken"]
        
    }
}
