//
//  WhiteFlowerConfiguration.swift
//  WhiteFlowerFactory
//
//  Created by Stephen Bodnar on 4/26/20.
//  Copyright © 2020 Stephen Bodnar. All rights reserved.
//

import Foundation

public final class WhiteFlowerConfiguration {
    
    public static let `default`: WhiteFlowerConfiguration = WhiteFlowerConfiguration()
    
    /// the queue where to receive callbacks
    internal let dispatchQueue: DispatchQueue
    
    /// default headers sent with every request
    internal var defaultHeaders: [HTTPHeader]
    
    internal let session: URLSession
    
    public init(dispatchQueue: DispatchQueue = .main, defaultHeaders: [HTTPHeader] = [], session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.dispatchQueue = dispatchQueue
        self.defaultHeaders = defaultHeaders
        self.session = session
    }
}
