//
//  MemberIdentifierList.swift
//  genericappios
//
//  Created by DC on 03/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import ObjectMapper

open class MemberIdentifierList : Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }

    var memberIdents:[MemberIdentifier]?
    
    
    public func mapping(map: Map) {
         memberIdents <- map["memberIdentifiers"]
    }
    
    public required init?() {
        
    }
    
}
