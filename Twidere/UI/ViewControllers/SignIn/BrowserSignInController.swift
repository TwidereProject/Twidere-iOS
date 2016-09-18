//
//  BrowserSignInController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/12.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import Kanna
import PromiseKit
import WebKit

class BrowserSignInController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    var customAPIConfig: CustomAPIConfig!
    var requestToken: OAuthToken!
    var callback: ((_ requestToken: OAuthToken, _ oauthVerifier: String?) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: self.view.frame, configuration: WKWebViewConfiguration())
        webView.navigationDelegate = self
        
        self.view.addSubview(webView)
        
        // Do any additional setup after loading the view.
        let endpoint = customAPIConfig.createEndpoint("api", noVersionSuffix: true, fixUrl: SignInController.fixSignInUrl)
        let requestUrl = endpoint.constructUrl("/oauth/authorize", queries: ["oauth_token": requestToken.oauthToken])
        let request = URLRequest(url: URL(string: requestUrl)!)
        webView.load(request)
    }
    
    @IBAction func cancelBrowserSignIn(_ sender: UIBarButtonItem) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        guard let url = webView.url else {
            return
        }
        
        if (url.host == "fanfou.com") {
            if (url.path == "/oauth/authorize") {
                let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
                
                let oauthCallbackIndex = components?.queryItems?.index { item -> Bool in
                    return item.name == "oauth_callback"
                }
                if (oauthCallbackIndex != nil) {
                    callback?(self.requestToken, nil)
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
             firstly { () -> Promise<String> in
                return Promise<String> { fullfill, reject in
                    webView.evaluateJavaScript("document.body.innerHTML") { (result, error) in
                        if let html = result as? String {
                            fullfill(html)
                        } else {
                            reject(BrowserSignInError.noContent)
                        }
                    }
                }
            }.then { html throws -> HTMLDocument in
                guard let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) else {
                    throw BrowserSignInError.parseError
                }
                return doc
            }.then { doc throws -> String? in
                let numericSet = NSCharacterSet.decimalDigits.inverted
                return doc.at_css("div#oauth_pin")?.css("*").filter({ (child) -> Bool in
                    if (child.text == nil) {
                        return false
                    }
                    return child.text!.rangeOfCharacter(from: numericSet) == nil
                }).first?.text
            }.then { oauthPin -> Void in
                if (oauthPin != nil) {
                    self.callback?(self.requestToken, oauthPin!)
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }.catch { error in
                    
            }
            
        }
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    internal enum BrowserSignInError: Swift.Error {
        case noContent
        case parseError
    }
    
}


