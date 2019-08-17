//
//  HTTPHeaderField.swift
//  WhiteFlowerFactory
//
//  Created by Stephen Bodnar on 8/15/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case contentLength = "Content-Length"
    case userAgent = "User-Agent"
    case accept = "Accept"
    case cacheControl = "Cache-Control"
}
