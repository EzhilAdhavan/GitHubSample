//
//  IssueModel.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/5/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import Foundation

struct IssueModel : Codable {
    
    let number : Int?
    let title : String?
    let created_at : String?
    let body_text : String?
    let user : User?
    
    enum CodingKeys: String, CodingKey {

        case number = "number"
        case title = "title"
        case created_at = "created_at"
        case body_text = "body_text"
        case user = "user"
    }

}


struct User : Codable {
    let login : String?
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        
    }
}

