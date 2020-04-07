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
    
    var path: String {
        switch self {
        case .url: return "https://www.httpbin.org"
        }
    }
    
    var baseURL: String {
        switch self {
        case .url: return "https://www.httpbin.org"
        }
    }
    
    static var name: String {
        return "MockProvider"
    }
    
    
}
