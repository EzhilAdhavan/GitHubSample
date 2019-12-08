//
//  FetchIssuesHandler.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/5/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import Foundation

class FetchIssuesHandler {
    
    static func fetchIssues(pageNo: String, state: IssueState, completion: @escaping (Result <[IssueModel], APIResponse>) -> ()) {
        
        Router<IssuesEndPoint>().request(IssuesEndPoint.fetchIssue(state: state, pageNo: pageNo), loadingView: nil) { (result) in
            
            switch result {
            
            case .success(let data, let response) :
                
                if let res = response as? HTTPURLResponse {
                    
                    switch res.verifyResponse() {
                    
                    case .success:
                        
                        guard let responseData = data else {
                            completion(.failure(APIResponse.noData))
                            return
                        }
                        
                        do {
                            
                            if let _ = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [[String:Any]] {
                                
                                let issueModel = try JSONDecoder().decode(Array<IssueModel>.self, from: responseData)
                                
                                completion(.success(issueModel))
                            }
                            
                        } catch {
                            
                            completion(.failure(APIResponse.unableToDecode))
                        }
                        
                        break
                        
                    case .failure( _):
                        
                        completion(.failure(APIResponse.requestFailed))
                        
                        break
                    }
                }
                
                break
            
            case .failure(_) :
                
                completion(.failure(.commonError))
                
                break
            }
        }
    }
    
}
