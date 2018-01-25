//
//  StoreList.swift
//  genericappios
//
//  Created by DC on 07/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation


open class CoffeeMilkTraderGroupList : Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
    
    var coffeeMilkTraderGroup:[CoffeeMilkTraderGroup]?
    
    
    public func mapping(map: Map) {
        coffeeMilkTraderGroup <- map["data"]
    }
    
    public required init?() {
        
    }
    
    public func getNames() -> [String]{
        var someInts = [String]()
        for  m in (coffeeMilkTraderGroup?.enumerated())!
        {
            someInts.append(m.element.groupId!)
        }
        return someInts
    }
    
    
    public func getGroupId(cofeeId : String, milkId : String) -> String{
        for  m in (coffeeMilkTraderGroup?.enumerated())!
        {
            if (m.element.coffeeId == cofeeId)&&(m.element.milkId == milkId){
                
                return m.element.groupId!
            }
        }
        return ""
    }
    
    
    
}
