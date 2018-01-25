//
//  Store.swift
//  genericappios
//
//  Created by DC on 07/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import ObjectMapper
import GoogleMaps

open class Store : Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
    
    
    
    
    public var lat  : String?
    public var long  : String?
    public var storeName  : String?
    public var storeDistanceS : String?
    public var storeDistance : Int? = 10000000
    public var origPos : Int?

    
    
    public required init?() {
        
    }
    
    
    open func mapping(map : Map){
        lat <- map["dataLat"]
        long <- map["dataLon"]
        storeName <- map["name"]
    }
    
    func  getLat() -> CLLocationDegrees {
        
        guard let n = NumberFormatter().number(from: lat!) else { return 0 }
        
        return CLLocationDegrees(truncating: n)

    }
    
    func  getLong() -> CLLocationDegrees {
        
        guard let n = NumberFormatter().number(from: long!) else { return 0 }
        
        return CLLocationDegrees(truncating: n)
        
    }
    
   
    
}
