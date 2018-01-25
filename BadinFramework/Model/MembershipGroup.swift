//
//  Milk.swift
//  genericappios
//
//  Created by DC on 14/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import ObjectMapper

open class MembershipGroup : Mappable {
    
    open var id:String?
    open var creationDate:String?
    open var startDate:String?
    open var endDate:String?
    open var member:String?
    open var membershipGroup:LookupField?
    

    
    
    public init( ) {
    }
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        id <- map["id"]
        creationDate <- map["creationDate"]
        startDate <- map["startDate"]
        endDate <- map["endDate"]
        member <- map["member"]
        membershipGroup <- map["membershipGroup"]
        
    }
}
