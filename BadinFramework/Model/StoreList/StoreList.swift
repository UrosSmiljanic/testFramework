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


open class StoreList : Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
    
        var storeList:[Store]?
    
    public func mapping(map: Map) {
        storeList <- map["data"]
       
    }
    
    public required init?() {
        
    }
    
    public func getCLocations() -> Array<CLLocation>{
        var locations: Array<CLLocation>  = Array()

        for object in storeList! {
            let coordinate = CLLocation(latitude: object.getLat(), longitude: object.getLong())
            locations.append(coordinate)
        }
        
        return locations
    
    }
    
}
