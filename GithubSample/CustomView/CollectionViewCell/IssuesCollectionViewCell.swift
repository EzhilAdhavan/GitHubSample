//
//  IssuesCollectionViewCell.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/6/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import UIKit

protocol IssueTableViewAction: NSObjectProtocol {
    func getSelectedIssue(issueModel: IssueModel)
    func getMoreIssues()
}

class IssuesCollectionViewCell: UICollectionViewCell {
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var issuesArray: [IssueModel] = [] {
        didSet{
            self.issuesTableVIew.reloadData()
        }
    }
    
    @IBOutlet weak var issuesTableVIew: UITableView!
    
    weak var delegate: IssueTableViewAction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        self.issuesTableVIew.dataSource = self
        
        self.issuesTableVIew.delegate = self
         
    }

}


extension IssuesCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issuesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.numberOfLines = 0
        
        let issueModel = self.issuesArray[indexPath.row]
        
        if let title = issueModel.title {
            cell.textLabel?.text = title
        }
        
        var subText = ""
        
        if let issueNo = issueModel.number {
            subText = String(describing: issueNo)
        }
        
        if let user = issueModel.user?.login {
            subText = subText + " by \(user)"
        }
        
        if let createAt = issueModel.created_at {
           
            if let formattedDate = createAt.toDate() {
            
                subText = subText + " on \(formattedDate.toString())"
            }
        }
        
        cell.textLabel?.text = issueModel.title ?? ""
        
        cell.detailTextLabel?.text = "#\(subText)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let delegate = self.delegate else { return }
        
        let issueModel = self.issuesArray[indexPath.row]
        
        delegate.getSelectedIssue(issueModel: issueModel)
        
    }
    
}

extension IssuesCollectionViewCell : UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y

        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 5.0 {

            guard let delegate = self.delegate else {
                return
            }

            delegate.getMoreIssues()
        }
    }
    
}
