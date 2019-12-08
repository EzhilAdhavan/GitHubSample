//
//  RequestTaskType.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/4/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum RequestTaskType {
    
    /*case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)*/
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)

}
