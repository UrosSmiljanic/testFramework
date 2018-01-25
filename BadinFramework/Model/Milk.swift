//
//  Milk.swift
//  genericappios
//
//  Created by DC on 14/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import ObjectMapper

open class Milk : Mappable {
    
    open var id:String?
    open var name:String?
    
    
    
    public init( ) {
    }
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        
    }
}
