//
//  IssuesViewModel.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/5/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewAction: NSObjectProtocol {
    func collecionViewSwiped()
    func getIssueModel(issueModel: IssueModel)
    func getMoreIssues()
}

class IssuesViewModel: NSObject {
    
    weak var delegate: CollectionViewAction?
    
    var openIssueModelArray:[IssueModel] = []
    
    var closedIssueModelArray:[IssueModel] = []
    
    func fetchIssues(pageNo: String, state: IssueState, completion: @escaping (Bool, Bool) -> Void) {
        
        FetchIssuesHandler.fetchIssues(pageNo: pageNo, state: state) { [weak self] (result) in
            
            switch result {
                
            case .success(let issueModelArr):
                                
                if state == IssueState.open {
                    
                    for model in issueModelArr {
                    
                        self?.openIssueModelArray.append(model)
                    }
                } else {
                    
                    for model in issueModelArr {
                        
                        self?.closedIssueModelArray.append(model)
                    }
                }
                
                completion(true, issueModelArr.count > 0 ? true : false)
                
                break
                
            case .failure(_):
                                
                completion(false, false)
                
                break
                
            }
        }
    }
}

//MARK:- UICollectionViewDataSource, UICollectionViewDelegate

extension IssuesViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssuesCollectionViewCell.identifier, for: indexPath) as! IssuesCollectionViewCell
        
        if indexPath.item == 0 {
            
            cell.issuesArray = self.openIssueModelArray
        
        }else {
        
            cell.issuesArray = self.closedIssueModelArray
        }
        
        cell.delegate = self
        
        return cell
        
    }
}

//MARK:- UIScrollViewDelegate

extension IssuesViewModel: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard let d = self.delegate else { return }
        
        d.collecionViewSwiped()
        
    }
}

//MARK:- IssueTableViewAction

extension IssuesViewModel: IssueTableViewAction {
    
    func getSelectedIssue(issueModel: IssueModel) {
        
        guard let d = self.delegate else { return }
        
        d.getIssueModel(issueModel: issueModel)
        
    }
    
    func getMoreIssues() {
        
        guard let d = self.delegate else { return }
        
        d.getMoreIssues()
    }
}
