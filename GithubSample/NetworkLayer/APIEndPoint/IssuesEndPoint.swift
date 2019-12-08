//
//  IssuesEndPoint.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/5/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import Foundation

enum IssuesEndPoint {
    case fetchIssue(state: IssueState, pageNo: String)
    
}

extension IssuesEndPoint : RequestSchema {
    var baseURL: URL {
        guard let baseUrl = URL(string: EnvironmentManager.environmentBaseURL) else {
            fatalError("baseURL could not be configured.")}
        return baseUrl
    }
    
    var path: String {
        switch self {
        case .fetchIssue:
            return "repos/alamofire/alamofire/issues"
        }
    }
    
    var httpMethod: HttpMethod {
        return HttpMethod.get
    }
    
    var task: RequestTaskType {
        switch self {
        case .fetchIssue(let state, let pageNo):
            
            let params = ["state": state.rawValue, "page": pageNo]
            let additionalHeader = ["Accept":"application/vnd.github.v3.full+json"]
            
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params, additionHeaders: additionalHeader)
            
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchIssue:
            return ["Content-Type":"application/json"]
        }
    }
    
    
}
