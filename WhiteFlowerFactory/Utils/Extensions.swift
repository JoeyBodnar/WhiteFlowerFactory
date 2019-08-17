//
//  Extensions.swift
//  WhiteFlowerFactory
//
//  Created by Stephen Bodnar on 8/15/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

extension Result where Success == Data? {
    
    /// attempts to parse the data to the given type
    /// fails either when parsing fails or if network request was a failure
    @discardableResult
    public func parse<T: Codable>(type: T.Type, onSuccess: ([T]) -> Void, onError: (Error?) -> Void) -> Result {
        switch self {
        case .success(let data):
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode([T].self, from: data ?? Data())
                onSuccess(json)
            } catch let error {
                onError(error)
            }
        case .failure(let error):
            onError(error)
        }
        
        return self
    }
    
    /// can safely call and will not be invoked if result is a failure
    /// returns self so we can chain actions
    @discardableResult
    public func parse<T: Codable>(type: T.Type, completion: ([T]) -> Void) -> Result {
        if case .success(let data) = self {
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode([T].self, from: data ?? Data())
                completion(json)
            } catch {
                // do not call completion if it fails
            }
        }
        
        return self
    }
    
    public func parse<T: Codable>(type: T.Type) -> [T]? {
        if case .success(let data) = self {
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode([T].self, from: data ?? Data())
                return json
            } catch {
                return nil
            }
        }
        
        return nil
    }
}

extension Result {
    // original source for these 2 methods: https://github.com/nsoojin/BookStore/blob/master/BookStore/Extensions/Result%20%2B%20Extensions.swift
    
    /// Will not be invoked if the result failed
    @discardableResult
    public func onSuccess(_ successHandler: (Success) -> Void) -> Result<Success, Failure> {
        if case .success(let value) = self {
            successHandler(value)
        }
        
        return self
    }
    
    /// Will not be invoked if the result succeeded
    @discardableResult
    public func onError(_ errorHandler: (Failure) -> Void) -> Result<Success, Failure> {
        if case .failure(let error) = self {
            errorHandler(error)
        }
        
        return self
    }
}
