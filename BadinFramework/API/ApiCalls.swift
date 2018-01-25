//
//  Members.swift
//  MobileApplication
//
//  Created by Dusan on 23/01/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

open class ApiCalls {
    
 
    open static func getMember(  success: @escaping (Member) -> Void, failure: @escaping (ErrorResponse) -> Void )  {
        ApiManager.execute (resourcePath: "/members/me", queryParams:[:], entity: Member()!, success: success, failure: failure)
        
        
    }
    
    open static func create(registrationDetails: Member, success: @escaping (Member) -> Void, failure: @escaping (ErrorResponse) -> Void ) {
        ApiManager.execute(resourcePath: "/members",   queryParams:[:],  entity: registrationDetails, success: success, failure: failure)
    }
    
    
    
    open static func getIdents(_ memberId: String, token: String, success: @escaping (MemberIdentifierListEmbedded) -> Void, failure: @escaping (ErrorResponse) -> Void )  {
        ApiManager.execute (resourcePath: "/members/"+memberId+"/memberIdentifiers/",  queryParams:[:],entity: MemberIdentifierListEmbedded()!, success: success, failure: failure)
        
    }
    
    open static func getTransSingle(_ memberId: String, token: String, success: @escaping (TransactionListEmbedded) -> Void, failure: @escaping (ErrorResponse) -> Void )  {
        
        ApiManager.execute (resourcePath: "/hda/members/"+memberId+"/transactions/?pageSize=1&page=0",  queryParams:["pageSize":"1", "page":"0"], entity: TransactionListEmbedded()!, success: success, failure: failure)
        
    }
    
    
    open static func getTransAll(_ memberId: String, success: @escaping (TransactionListEmbedded) -> Void, failure: @escaping (ErrorResponse) -> Void )  {
        ApiManager.execute (resourcePath: "/hda/members/"+memberId+"/transactions/?pageSize=200&page=0&expand=childTransactions,vouchers",  queryParams:["pageSize":"200", "page":"0"], entity: TransactionListEmbedded()!, success: success, failure: failure)
        
    }
    
    
    
    open static func getVoucherSingle(_ memberId: String,  success: @escaping (VoucherListEmbedded) -> Void, failure: @escaping (ErrorResponse) -> Void )  {
        
        ApiManager.execute (resourcePath: "/hda/members/"+memberId+"/vouchers/?pageSize=100&page=0&status=ACTIVE",   queryParams:["status":"ACTIVE"], entity: VoucherListEmbedded()!, success: success, failure: failure)
        
    }
    
    
    open static func getVoucherAll(_ memberId: String, success: @escaping (VoucherListEmbedded) -> Void, failure: @escaping (ErrorResponse) -> Void )  {
        ApiManager.executeGet (resourcePath: "/hda/members/"+memberId+"/vouchers/?pageSize=200&page=0&status=ACTIVE",  queryParams:["status":"ACTIVE"], entity: VoucherListEmbedded()!, success: success, failure: failure)
        
    }
    
    
    open static func updateDetails(_ member: Member, success: @escaping (Bool) -> Void, failure: @escaping (ErrorResponse) -> Void ) {
        
        Alamofire.request(  TTLUtils.baseURL + "members/"+KeychainWrapper.standard.string(forKey: "userId")!+"/",
                            method: .put,
                            parameters: member.toJSON(),
                            encoding: JSONEncoding.default,
                            headers: ["moduleCode":"CM_IOS", "Content-Type":"application/json", "Authorization":KeychainWrapper.standard.string(forKey: "token")! ])
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
                    
                    success(true)
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
    
    
    open static func registerMember(_ member: Member, success: @escaping (Bool) -> Void, failure: @escaping (ErrorResponse) -> Void ) {
        
        Alamofire.request(  TTLUtils.baseURL + "members/",
                            method: .post,
                            parameters: member.toJSON(),
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
                    
                    success(true)
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
    
    
    open static func resetPassword(_ member: Member, success: @escaping (Bool) -> Void, failure: @escaping (ErrorResponse) -> Void ) {
        
        Alamofire.request(  TTLUtils.baseURL + "resetToken",
                            method: .post,
                            parameters: member.toJSON(),
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
                    
                    success(true)
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

    
    
    
    func handleSuccessfulLogin(_ member: MemberIdentifier) {
        
        
        
    }
    
    func handleFailedLogin(_ err: ErrorResponse) {
        
    }
    
    //let MCARD = "https://transactortech.co.nz/mCardServer2.21/mCardService";

    open static func replaceCard(_ replaceCard: ReplaceCard, success: @escaping (Bool) -> Void, failure: @escaping (ErrorResponse) -> Void ) {
        
        Alamofire.request( "https://transactortech.co.nz/mCardServer2.21/mCardService",
                            method: .post,
                            parameters: replaceCard.toJSON(),
                            encoding: JSONEncoding.default
            )
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
                    if (responseBody.contains("Error")){
                        let error = ErrorResponse(JSONString: responseBody) 
                        failure(error!)
                        return
                    }
                    
                    success(true)
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
    
    
    //        Call<StoreListmCard> a = RestClient.get().getStores(new StoreRequest("columbusstoregroupsmemberships", "182", "3"));
    open static func getStores( success: @escaping (StoremCardList) -> Void, failure: @escaping (ErrorResponse) -> Void ) {
        let storeRequest = StoreRequest()
        storeRequest.programID = "182"
        storeRequest.requestType = "columbusstoregroupsmemberships"
        storeRequest.typeID = "3"
       
        
        Alamofire.request( "https://transactortech.co.nz/mCardServer2.21/mCardService",
                           method: .post,
                           parameters: storeRequest.toJSON(),
                           encoding: JSONEncoding.default
            )
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
                    
                    let responseEntity = StoremCardList(JSONString: responseBody)!
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
    }
 
    open static func getMemberships(_ memberId: String, token: String, success: @escaping (Membership) -> Void, failure: @escaping (ErrorResponse) -> Void )  {
        ApiManager.execute (resourcePath: "/members/"+memberId+"/memberships/",  queryParams:[:],entity: Membership()!, success: success, failure: failure)
        
    }
    
    open static func createMemberships(_ membership: MembershipGroup, success: @escaping (Bool) -> Void, failure: @escaping (ErrorResponse) -> Void ) {
        
        Alamofire.request(  TTLUtils.baseURL + "/memberships/",
                            method: .post,
                            parameters: membership.toJSON(),
                            encoding: JSONEncoding.default,
                            headers: ["moduleCode":"CM_IOS", "Content-Type":"application/json", "Authorization":KeychainWrapper.standard.string(forKey: "token")! ])
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
                    success(true)
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
    open static func updateMemberships(_ membership: MembershipGroup, success: @escaping (Bool) -> Void, failure: @escaping (ErrorResponse) -> Void ) {
        
        Alamofire.request(  TTLUtils.baseURL + "/memberships/" + membership.id!,
                            method: .put,
                            parameters: membership.toJSON(),
                            encoding: JSONEncoding.default,
                            headers: ["moduleCode":"CM_IOS", "Content-Type":"application/json", "Authorization":KeychainWrapper.standard.string(forKey: "token")! ])
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
                    success(true)
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
