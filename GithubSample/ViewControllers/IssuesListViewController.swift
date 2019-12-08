//
//  IssuesListViewController.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/6/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import UIKit

class IssuesListViewController: UIViewController {
    
    @IBOutlet weak var issuesCollectionView: UICollectionView!
    
    @IBOutlet weak var customSegment: CustomSegment!{
        didSet{
            self.customSegment.delegate = self
            self.customSegment.segmentItems = ["Open", "Closed"]
        }
    }
    
    var openPageNo: Int! = 1
    var closedPageNo: Int! = 1
    
    private let issueViewModel = IssuesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.issuesCollectionView.dataSource = self.issueViewModel
        
        self.issuesCollectionView.delegate = self.issueViewModel
        
        self.issueViewModel.delegate = self
        
        self.issuesCollectionView.register(IssuesCollectionViewCell.nib, forCellWithReuseIdentifier: IssuesCollectionViewCell.identifier)
        
        self.fetchIssue(page: self.openPageNo, state: .open)
        
    }
    
    //MARK:- Mehods
    
    private func fetchIssue(page: Int, state: IssueState) {
             
        self.issueViewModel.fetchIssues(pageNo: String(describing: page), state: state) { [weak self] (isSuccess, isContainsItems) in
            
            if isSuccess {
        
                if self?.customSegment.selectedItem == 0 {
                 
                    self?.openPageNo = isContainsItems ? (self!.openPageNo + 1) : self?.openPageNo
                
                }else{
                
                    self?.closedPageNo = isContainsItems ? (self!.closedPageNo + 1) : self?.closedPageNo
                }
                
                DispatchQueue.main.async {
                
                    self?.issuesCollectionView.reloadData()
                }
            }
        }
    }

}

//MARK:- SegmentValueChangedDelegate

extension IssuesListViewController: SegmentValueChangedDelegate {
    
    func segmentValueChanged(segmentControl: UISegmentedControl) {
        
        self.customSegment.selectedItem = segmentControl.selectedSegmentIndex
        
        let indexPath = IndexPath(item: segmentControl.selectedSegmentIndex, section: 0)
        
        self.issuesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if self.customSegment.selectedItem == 1 {
        
            if self.issueViewModel.closedIssueModelArray.count == 0 {
            
                self.fetchIssue(page: self.closedPageNo, state: .closed)
            }
        }
    }
}

//MARK:- CollectionViewAction

extension IssuesListViewController: CollectionViewAction {
   
    func collecionViewSwiped() {
            
        var visibleRect = CGRect()
        
        visibleRect.origin = issuesCollectionView.contentOffset
        
        visibleRect.size = issuesCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = issuesCollectionView.indexPathForItem(at: visiblePoint) else { return }
        
        self.customSegment.selectedItem = indexPath.item
        
        if self.customSegment.selectedItem == 1 {
           
            if self.issueViewModel.closedIssueModelArray.count == 0 {
            
                self.fetchIssue(page: self.closedPageNo, state: .closed)
            }
        }
    }
    
    func getIssueModel(issueModel: IssueModel) {
        
        guard let bodyText = issueModel.body_text else { return }
        
         let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailVC.bodyHtml = bodyText
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    func getMoreIssues() {
        if self.customSegment.selectedItem == 0 {
            self.fetchIssue(page: self.openPageNo, state: .open)
        }else{
            self.fetchIssue(page: self.closedPageNo, state: .closed)
        }
    }
}


