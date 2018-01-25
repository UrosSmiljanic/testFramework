//
//  MemberIdentifierListEmbedded.swift
//  genericappios
//
//  Created by DC on 03/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import ObjectMapper

open class TransactionListEmbedded: Mappable {

    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
    
    var transactionList:TransactionList?
    
    
    public func mapping(map: Map) {
        transactionList <- map["_embedded"]
    }
    
    public required init?() {
        
    }
    

}
