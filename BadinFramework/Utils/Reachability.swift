//
//  Reachability.swift
//  genericappios
//
//  Created by DC on 09/10/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import Foundation


/// This class is designed to check if the network is connected.
open class Reachability {
    
         class func isConnectedToNetwork(_ resultHandler: @escaping (_ isTrue: Bool) -> Void) {
        let urlA = URL(string: "https://google.com/")
        let urlB = URL(string: "https://tranxactor.com/")
        
        Reachability.fetchURL(urlA!) { isTrue in
            if isTrue {
                print("NETWORK STATUS: \(isTrue)")
                resultHandler(isTrue)
            } else {
                Reachability.fetchURL(urlB!, resultHandler: resultHandler)
            }
        }
    }
    
      class func fetchURL(_ url:URL, resultHandler: @escaping (_ isTrue: Bool) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    resultHandler(true)
                } else {
                    resultHandler(false)
                }
            } else {
                resultHandler(false)
            }
        }
        dataTask.resume()
    }
}
