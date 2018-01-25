//
//  Tokens.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

open class Tokens {
 
    open static func create(_ credentials: Login, success: @escaping (Token) -> Void, failure: @escaping (ErrorResponse) -> Void ) {
        
        Alamofire.request(  TTLUtils.baseURL + "tokens",
            method: .post,
            parameters: credentials.toJSON(),
            encoding: JSONEncoding.default,
            
            headers: ["moduleCode":"CM_IOS", "Content-Type":"application/json"])
            .responseData { (response) -> Void in
                debugPrint("Entering response handler...")
                
                // HTTP/Network error handler
                guard response.result.isSuccess else {
                    debugPrint("There has been a network error")
                    let error = ErrorResponse(userErrorMessage: response.result.error!.localizedDescription)
                    failure(error)
                    return
                }
                
                // Handle positive 200-299 response
                let responseBody = String(data: response.result.value!, encoding: String.Encoding.utf8)!
                guard let httpCode = response.response?.statusCode, !(200 ... 299).contains(httpCode) else {
                    let myToken = Token(JSONString: responseBody)!
           //         debugPrint(myToken.toJSONString(true))
                    KeychainWrapper.standard.set(myToken.token, forKey: "token")
                    KeychainWrapper.standard.set(myToken.userId, forKey: "userId")
                    KeychainWrapper.standard.set(myToken.masterToken, forKey: "masterToken")
                    KeychainWrapper.standard.set(myToken.userName, forKey: "userName")
                    KeychainWrapper.standard.set(credentials.password!, forKey: "password")

                    success(myToken)
                    return
                }
                
                // Handle API error response. Server responded with an invalid request
                let error = ErrorResponse(JSONString: responseBody)
                error?.httpOutcomeCode = httpCode
                error?.requestId = response.request?.allHTTPHeaderFields?.filter {
                    (key, value) in
                        return key == "requestId"
                    }.first.map{ (key, value) in
                        return value
                }
                failure(error!)
                return
        }
    }
}
