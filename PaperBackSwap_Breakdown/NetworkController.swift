//
//  NetworkController.swift
//  PaperBackSwap_Breakdown
//
//  Created by Diego Aguirre on 7/27/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class NetworkController {
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Patch = "PATCH"
        case Delete = "DELETE"
    }
    
    static func performRequestForURL(url: NSURL, httpMethod: HTTPMethod, urlParameters: [String: String]? = nil, body: NSData? = nil, completion:((data: NSData?, error: NSError?) -> Void)?) {
        
        let url = urlFromURLParameters(url, urlParameters: urlParameters)
        
        let mutableRequest = NSMutableURLRequest(URL: url)
        mutableRequest.HTTPBody = body
        mutableRequest.HTTPMethod = httpMethod.rawValue
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(mutableRequest) { (data, response, error) in
            if let completion = completion {
                completion(data: data, error: error)
            }
        }
        dataTask.resume()
    }
    
    static func urlFromURLParameters(url: NSURL, urlParameters: [String: String]?) -> NSURL {
        
        let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: true)
        
        components?.queryItems = urlParameters?.flatMap({NSURLQueryItem(name: $0.0, value: $0.1)})
        
        if let url = components?.URL {
            return url
        } else {
            fatalError("URL optional is nil")
        }
    }
}