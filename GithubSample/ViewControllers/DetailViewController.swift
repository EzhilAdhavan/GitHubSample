//
//  DetailViewController.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/6/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var bodyHtml: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.loadHTMLString(self.bodyHtml, baseURL: nil)
    
    }
}
