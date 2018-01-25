//
//  MemberIdentifierList.swift
//  genericappios
//
//  Created by DC on 03/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import ObjectMapper

open class TransactionList : Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }

    var transactions:[Transaction]?
    
    
    public func mapping(map: Map) {
         transactions <- map["transactions"]
    }
    
    public required init?() {
        
    }
    
}
