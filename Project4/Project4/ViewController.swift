//
//  ViewController.swift
//  Project4
//
//  Created by Mitchell Mackenzie Sell on 2021-05-19.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites: [String]!
    var website: String!
    
    override func loadView() {
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            navigationItem.largeTitleDisplayMode = .never
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self , action: #selector(openTapped))
            
            progressView = UIProgressView(progressViewStyle: .default)
            progressView.sizeToFit()
            let progressButton = UIBarButtonItem(customView: progressView)
            
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
            let goBack = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
            let goForward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
            
            
            toolbarItems = [progressButton, spacer,goBack, goForward, refresh] //Order here matters
            
            navigationController?.isToolbarHidden = false
            
            //key-value observing (KVO), and it effectively lets you say, "please tell me when the property X of object Y gets changed by anyone at any time."
            webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
            //Warning: in more complex applications, all calls to addObserver() should be matched with a call to removeObserver() when you're finished observing
            
            
            let url = URL(string: "https://" + website + ".com")!
            webView.load(URLRequest(url:url))
            webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }


    @objc func openTapped() {
        
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        for websiteSelectedButton in websites {
            
        ac.addAction(UIAlertAction(title: websiteSelectedButton, style: .default, handler: openPage))
        
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac, animated: true)
        
    }

    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "https://" + actionTitle + ".com") else {return}
        webView.load(URLRequest(url: url))
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    //escaping closure - closure has the ability to escape from the current method and be used at a later date
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        
        if let host = url?.host {
            
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
                
            }
            
        }
        
        decisionHandler(.cancel)
        
        let blockedPage = UIAlertController(title: "Blocked", message: "You may not access this page", preferredStyle: .alert)
        blockedPage.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil ))
        present(blockedPage, animated: true)
        
    
    }
    
    
    
}

