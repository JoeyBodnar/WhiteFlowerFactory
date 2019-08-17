//
//  DataTaskresponse.swift
//  NetworkingFramework
//
//  Created by Stephen Bodnar on 8/15/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

/// When we pass back the result to the user in the completion handler, sometimes
/// the user might want access to the original data and response that resulted from the session.datatask(with: ..) call
/// so we wrap that info in this object and pass this back as part of the APIResponse completion
public class DataTaskResponse {
    var data: Data?
    var response: URLResponse?
    
    init(data: Data?, response: URLResponse?) {
        self.data = data
        self.response = response
    }
}
