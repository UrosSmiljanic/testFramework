//
//  StoreRequest.swift
//  genericappios
//
//  Created by DC on 13/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation


open class StoreRequest: Mappable {
   
    open var requestType:String?
    open var typeID:String?
    open var programID:String?
    
    
    public init() {
        
    }
    
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        requestType <- map["requestType"]
        typeID <- map["typeID"]
        programID <- map["programID"]
        
    }

}
