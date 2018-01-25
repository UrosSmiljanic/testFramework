//
//  Error.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import ObjectMapper

open class ErrorResponse : Mappable {
    
    open var userErrorMessage:String = "Unable to execute remote request"
    open var developerErrorMessage:String?
    open var httpOutcomeCode:Int?
    open var apiErrorCode:String?
    open var requestId:String?
    open var description:String?

    public init(userErrorMessage:String, developerErrorMessage:String? = nil, httpCode:Int? = nil, apiErrorCode: String? = nil, requestId:String? = nil) {
        self.userErrorMessage = userErrorMessage
        self.developerErrorMessage = developerErrorMessage
        self.httpOutcomeCode = httpCode
        self.requestId = requestId
    }
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        userErrorMessage <- map["errorMessage"]
        developerErrorMessage <- map["developerErrorMessage"]
        httpOutcomeCode <- map["httpStatusCode"]
        apiErrorCode <- map["errorCode"]
        description <- map["description"]

    }
}
