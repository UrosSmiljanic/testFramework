//
//  CoffeeMilkTraderGroup.swift
//  genericappios
//
//  Created by DC on 14/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import ObjectMapper

open class CoffeeMilkTraderGroup : Mappable {
    
    open var coffeeId:String?
    open var milkId:String?
    open var groupId:String?

    
    
    public init( ) {
    }
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        coffeeId <- map["coffeeId"]
        milkId <- map["milkId"]
        groupId <- map["groupId"]
    }
}
