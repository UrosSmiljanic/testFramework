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


open class MilkList : Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
    
    var milkList:[Milk]?
    
    
    public func mapping(map: Map) {
        milkList <- map["data"]
    }
    
    public required init?() {
        
    }
    
    public func getNames() -> [String]{
        var someInts = [String]()
        for  m in (milkList?.enumerated())!
        {
           someInts.append(m.element.name!)
        }
        return someInts
    }
    
    public func getName(id:String) -> String{
       for  m in (milkList?.enumerated())!
        {
            if (m.element.id == id){ return m.element.name!}
        }
        return ""
    }
    
    public func getId(name:String) -> String{
        for  m in (milkList?.enumerated())!
        {
            if (m.element.name == name){ return m.element.id!}
        }
        return ""
    }
    
}
