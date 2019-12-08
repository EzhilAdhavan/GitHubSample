//
//  Environment.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/4/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import Foundation

enum NBNetworkEnvironment {
    case debug
    case release
}

struct EnvironmentManager {

    static let environment:NBNetworkEnvironment = .release

    static var environmentBaseURL:String {
        
        switch EnvironmentManager.environment {
            
        case .debug:
            return "https://api.github.com/"
        
        case .release:
            return "https://api.github.com/"
        }
        
    }
    
}
