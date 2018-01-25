//
//  StoremCard.swift
//  genericappios
//
//  Created by DC on 13/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

open class StoremCard: Mappable {
    
 
    
    open var memberId:String?
    open var memberName:String?
    open var groupId:String?
    open var groupName:String?
    open var groupDescription:String?
    open var parentId:String?

    
    public init() {
        
    }
    
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        memberId <- map["memberId"]
        memberName <- map["memberName"]
        groupId <- map["groupId"]
        groupName <- map["groupName"]
        groupDescription <- map["groupDescription"]
        parentId <- map["parentId"]
        
    }

    

}
