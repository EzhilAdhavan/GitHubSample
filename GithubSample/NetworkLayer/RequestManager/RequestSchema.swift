//
//  RequestSchema.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/4/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import Foundation

protocol RequestSchema {
    var baseURL : URL { get }
    var path : String { get }
    var httpMethod : HttpMethod { get }
    var task : RequestTaskType { get }
    var headers : HTTPHeaders? { get }
}
