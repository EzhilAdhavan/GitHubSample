//
//  Constants.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/6/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import Foundation

enum IssueState: String {
    case open = "open"
    case closed = "closed"
}


extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ")-> Date?{
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: self)
        
        return date
    }
}

extension Date {

    func toString(withFormat format: String = "dd/MM/yyyy, EEE") -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        
        let str = dateFormatter.string(from: self)
        
        return str
    }
}
