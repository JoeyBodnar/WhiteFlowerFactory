//
//  SerialQueueRequest.swift
//  WhiteFlowerFactory
//
//  Created by Stephen Bodnar on 8/15/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

/// Just a simple abstraction on top of URLRequest.
/// To make a request with WhiteFlower, you must first create a white flower request. All network requests are routed through this class. 
public class WhiteFlowerRequest {
    var urlString: String
    var method: HTTPMethod
    
    var endPoint: Provider?
    var headers: [HTTPHeader]?
    var params: [String: Any]?
    
    public init(method: HTTPMethod, urlString: String) {
        self.method = method
        self.urlString = urlString
    }
    
    public convenience init<T: Provider>(method: HTTPMethod, endPoint: T) {
        self.init(method: method, urlString: endPoint.path)
    }
    
    public convenience init<T: Provider>(method: HTTPMethod, endPoint: T, params: [String: Any]?) {
        self.init(method: method, urlString: endPoint.path)
        self.params = params
    }
    
    public convenience init<T: Provider>(method: HTTPMethod, endPoint: T, params: [String: Any]?, headers: [HTTPHeader]?) {
        self.init(method: method, urlString: endPoint.path)
        self.params = params
        self.headers = headers
    }
    
    public convenience init<T: Provider>(method: HTTPMethod, endPoint: T, headers: [HTTPHeader]?) {
        self.init(method: method, urlString: endPoint.path)
        self.headers = headers
    }
    
    /// The URLRequest for a given instance of WhiteFlowerRequest
    var urlRequest: URLRequest? {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            if method != .get {
                request.setValue(HTTPContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            }
            do {
                if let postBody = params {
                    request.httpBody = try JSONSerialization.data(withJSONObject: postBody, options: JSONSerialization.WritingOptions.prettyPrinted)
                } else { print("params were nil") }
            } catch { print("couldnt set http body of page view") }
            
            if let unwrappedHeaders = headers {
                for header in unwrappedHeaders {
                    request.setValue(header.value, forHTTPHeaderField: header.field)
                }
            }
            
            return request
        } else {
            return nil
        }
    }
}
