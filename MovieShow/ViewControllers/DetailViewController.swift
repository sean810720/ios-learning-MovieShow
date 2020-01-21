//
//  DetailViewController.swift
//  MovieShow
//
//  Created by Sean on 2020/1/21.
//  Copyright © 2020 Sean. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var pageTitle: String!
    var Url: String!

    @IBOutlet weak var backNavigationItem: UINavigationItem!
    
    // MARK: - 頁面載入時執行
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = pageTitle
        
        if let backBarButtonItem = backNavigationItem.backBarButtonItem {
            backBarButtonItem.title = "電影情報"
        }
        
        let myURL = URL(string: Url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
