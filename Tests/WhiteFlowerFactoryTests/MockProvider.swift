//
//  MockProvider.swift
//  WhiteFlowerFactoryTests
//
//  Created by Stephen Bodnar on 4/7/20.
//  Copyright © 2020 Stephen Bodnar. All rights reserved.
//

import Foundation

enum MockProvider: Provider {
    
    case url
    case get
    case post
    
    var path: String {
        switch self {
        case .url: return "\(baseURL)"
        case .get: return "\(baseURL)/get"
        case .post: return "\(baseURL)/post"
        }
    }
    
    var baseURL: String {
        return "https://www.httpbin.org"
    }
    
    static var name: String {
        return "MockProvider"
    }
}
