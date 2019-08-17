//
//  HTTPContentType.swift
//  WhiteFlowerFactory
//
//  Created by Stephen Bodnar on 8/15/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

public enum HTTPContentType: String {
    case json = "application/json"
    case urlEncoded = "application/x-www-form-urlencoded"
    case png = "image/png"
    case jpeg = "image/jpeg"
    case mp4 = "video/mp4"
    case xml = "text/xml"
    case textPlain = "text/plain"
    case gif = "image/gif"
}
