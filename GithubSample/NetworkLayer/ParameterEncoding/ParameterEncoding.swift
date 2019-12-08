//
//  ParameterEncoding.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/4/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import Foundation


public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {
    
    case urlEncoding
    
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {
        do {
            
            switch self {
                
            case .urlEncoding:
                
                guard let urlParameters = urlParameters else { return }
                
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
            }
        }catch{
            throw error
        }
    }
}


public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
