//
//  ApiManager.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import JWTDecode

open class ApiManager {
    open var header:[String:String] = [:]
    
     internal static var headers = ["Authorization":"","moduleCode":"CM_IOS", "Content-Type":"application/json"]
    
    internal static var principal:Token?
    
    public init() { }
    
    
    
    open static func execute<T>(resourcePath:String, queryParams:[String:String], entity: T, success: @escaping (T) -> Void, failure: @escaping (ErrorResponse) -> Void ) where T:Mappable {
        
        do
        {
            let data = try decode(jwt: KeychainWrapper.standard.string(forKey: "token")! )
            
            if (!data.expired)
            {
                executeGet(resourcePath: resourcePath,   queryParams: queryParams,  entity: entity, success: success, failure: failure)
                
            }
                
                
            else {
                let credentials:Login = Login(masterToken: KeychainWrapper.standard.string(forKey: "masterToken")!)
                // Tokens.refresh(credentials, success: handleSuccessfulLogin, failure: handleFailedLogin)
                
                
                Alamofire.request(  TTLUtils.baseURL+"tokens/refresh",
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
                            
                            
                            executeGet(resourcePath: resourcePath,   queryParams: queryParams,  entity: entity, success: success, failure: failure)
                            
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
        catch {
            return
        }
        return
    }
    open static func executeGet<T>(resourcePath:String, queryParams:[String:String], entity: T, success: @escaping (T) -> Void, failure: @escaping (ErrorResponse) -> Void ) where T:Mappable {
        
        
        headers.updateValue(KeychainWrapper.standard.string(forKey: "token")! , forKey: "Authorization")
        
        Alamofire.request(  TTLUtils.baseURL + resourcePath,
                           // parameters: queryParams,
            encoding: JSONEncoding.default,
            headers: headers)
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
                    if (responseBody != "")
                    { let responseEntity = T(JSONString: responseBody)!
                    debugPrint(responseBody)
                    success(responseEntity)
                        
                    }
                    else {
                        let responseEntity = T(JSONString: "{}")!
                        success(responseEntity)

                    }
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
        
        return
    }
    
    
    
    
    //MARK: available functions
    open func create<T:Mappable>(_ resourcePath:String, resourceId:String, entity:T, success: @escaping (T) -> Void, failure: @escaping (ErrorResponse) -> Void ) {
        let url=TTLUtils.baseURL + resourcePath + "/" + resourceId;
        //   Alamofire.request(url,     entity, encoding: URLEncoding.httpBody, headers: header)
        Alamofire.request(url,  parameters: entity.toJSON(), encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
                print(response.result.value as Any)   // result of response serialization
                
                
        }
        
        func getSingle<T>(_ resourcePath:String, resourceId:String,headers: [String:String], queryParams:[String:String], success: @escaping (T) -> Void, failure: @escaping (ErrorResponse) -> Void ) where T:Mappable {
            Alamofire.request(  TTLUtils.baseURL + resourcePath + "/" + resourceId,
                                parameters: queryParams,
                                encoding:URLEncoding.queryString,
                                headers: headers).responseData { (response) in
                                    handleSingleResult(response, success: success, failure: failure)
            }
            
        }
        
        func getCollection<T:Mappable>(_ resourcePath:String, pageNumber:Int = 1, pageSize:Int = 20, queryParams:[String:String], success: @escaping ([T]) -> Void, failure: @escaping (ErrorResponse) -> Void ) {
            Alamofire.request(  TTLUtils.baseURL + resourcePath,
                                parameters: queryParams,
                                encoding: URLEncoding.queryString,
                                headers: header).responseData { (response) in
                                    handleListResult(response, success: success, failure: failure)
            }
        }
        
        //MARK: Handlers
        func handleSingleResult<T:Mappable>(_ response:DataResponse<Data>, success: (T) -> Void, failure: (ErrorResponse) -> Void) {
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
                let responseEntity = T(JSONString: responseBody)!
                // debugPrint(responseEntity.toJSONString(prettyPrint: true))
                success(responseEntity)
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
        
        func handleListResult<T:Mappable>(_ response:DataResponse<Data>, success: ([T]) -> Void, failure: (ErrorResponse) -> Void) {
            debugPrint("Entering response handler...")
            
            // HTTP/Network error handler
            guard response.result.isSuccess else {
                debugPrint("There has been a network error")
                let error = ErrorResponse(userErrorMessage: response.result.error!.localizedDescription)
                failure(error)
                return
            }
            
            // Handle positive 200-299 response
            let responseBody:String = String(data: response.result.value! as Data, encoding: String.Encoding.utf8)!
            guard let httpCode = response.response?.statusCode, !(200 ... 299).contains(httpCode) else {
                let entityList: Array<T> = Mapper<T>().mapArray(JSONString:responseBody)!
                //      debugPrint(entityList.toJSONString(prettyPrint: true) ?? default true)
                success(entityList)
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
