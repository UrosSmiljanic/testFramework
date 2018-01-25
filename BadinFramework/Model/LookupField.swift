//
//  LookupField.swift
//  genericappios
//
//  Created by DC on 04/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import ObjectMapper

open class LookupField: Mappable {
    
    public required init?(map: Map) {
        
    }
    
    
    
    public var moduleCode  : String?
    public var id : String?
    public var value : String?
    
    
    
    public required init?() {
        
    }
    
    
    open func mapping(map : Map){
        moduleCode <- map["moduleCode"]
        id <- map["id"]
        value <- map["value"]
    }


}
