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


open class CoffeeList : Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
    
    var coffeeList:[Coffee]?
    
    
    public func mapping(map: Map) {
        coffeeList <- map["data"]
    }
    
    public required init?() {
        
    }
    
    public func getNames() -> [String]{
        var someInts = [String]()
        for  m in (coffeeList?.enumerated())!
        {
            someInts.append(m.element.name!)
        }
        return someInts
    }
    
    public func getName(id:String) -> String{
        for  m in (coffeeList?.enumerated())!
        {
            if (m.element.id == id){ return m.element.name!}
        }
        return ""
    }
    public func getId(name:String) -> String{
        for  m in (coffeeList?.enumerated())!
        {
            if (m.element.name == name){ return m.element.id!}
        }
        return ""
    }

    
}
