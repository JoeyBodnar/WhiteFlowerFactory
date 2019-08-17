//
//  APIResponse.swift
//  NetworkingFramework
//
//  Created by Stephen Bodnar on 8/15/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

/// The response to all API calls
public class APIResponse {
    var originalRequest: URLRequest? // Requests aborted by invalidURL will not have an originalRequest
    var dataTaskResponse: DataTaskResponse?
    var result: Result<Data, NetworkError>
    
    init(dataTaskResponse: DataTaskResponse?, result: Result<Data, NetworkError>, originalRequest: URLRequest?) {
        self.dataTaskResponse = dataTaskResponse
        self.result = result
        self.originalRequest = originalRequest
    }
    
    convenience init(data: Data?, response: URLResponse?, error: Error?, originalRequest: URLRequest?) {
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
        
        let originalResponse = DataTaskResponse(data: data, response: response)
        
        switch statusCode {
        case 200..<400: self.init(dataTaskResponse: originalResponse, result: .success(data!), originalRequest: originalRequest)
        case 400:
            let error: Result<Data, NetworkError> = .failure(.badRequest(statusCode))
            self.init(dataTaskResponse: originalResponse, result: error, originalRequest: originalRequest)
        case 401:
            let error: Result<Data, NetworkError> = .failure(.unauthorized(statusCode))
            self.init(dataTaskResponse: originalResponse, result: error, originalRequest: originalRequest)
        case 403:
            let error: Result<Data, NetworkError> = .failure(.forbidden(statusCode))
            self.init(dataTaskResponse: originalResponse, result: error, originalRequest: originalRequest)
        case 404:
            let error: Result<Data, NetworkError> = .failure(.notFound(statusCode))
            self.init(dataTaskResponse: originalResponse, result: error, originalRequest: originalRequest)
        case 405..<500:
            let error: Result<Data, NetworkError> = .failure(.requestFailed(statusCode))
            self.init(dataTaskResponse: originalResponse, result: error, originalRequest: originalRequest)
        case 500..<600: let error: Result<Data, NetworkError> = .failure(.serverError(statusCode))
        self.init(dataTaskResponse: originalResponse, result: error, originalRequest: originalRequest)
        default:
            self.init(dataTaskResponse: originalResponse, result: .failure(.badRequest(statusCode)), originalRequest: originalRequest)
        }
    }
}

