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

class BrowserSignInController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var customAPIConfig: CustomAPIConfig!
    var requestToken: OAuthToken!
    var callback: ((_ requestToken: OAuthToken, _ oauthVerifier: String?) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let endpoint = customAPIConfig.createEndpoint("api", noVersionSuffix: true, fixUrl: SignInController.fixSignInUrl)
        let requestUrl = endpoint.constructUrl("/oauth/authorize", queries: ["oauth_token": requestToken.oauthToken])
        let request = URLRequest(url: URL(string: requestUrl)!)
        webView.loadRequest(request)
        webView.delegate = self
    }
    
    @IBAction func cancelBrowserSignIn(_ sender: UIBarButtonItem) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        guard let request = webView.request else {
            return
        }
        guard let url = request.url else {
            return
        }
        if (url.host == "fanfou.com") {
            if (url.path == "/oauth/authorize") {
                let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
                
                let oauthCallbackIndex = components?.queryItems?.index { item -> Bool in
                    return item.name == "oauth_callback"
                }
                if (oauthCallbackIndex != nil) {
                    callback(requestToken: self.requestToken, oauthVerifier: nil)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            
             firstly { () -> Promise<String> in
                return Promise<String> { fullfill, reject in
                    if let html = webView.stringByEvaluatingJavaScriptFromString("document.body.innerHTML") {
                        fullfill(html)
                    } else {
                        reject(BrowserSignInError.NoContent)
                    }
                    
                }
            }.then { html throws -> HTMLDocument in
                guard let doc = Kanna.HTML(html: html, encoding: NSUTF8StringEncoding) else {
                            throw BrowserSignInError.ParseError
                }
                return doc
            }.then { doc throws -> String? in
                let numericSet = NSCharacterSet.decimalDigitCharacterSet().invertedSet
                return doc.at_css("div#oauth_pin")?.css("*").filter({ (child) -> Bool in
                    if (child.text == nil) {
                        return false
                    }
                    return child.text!.rangeOfCharacterFromSet(numericSet) == nil
                }).first?.text
            }.then { oauthPin -> Void in
                if (oauthPin != nil) {
                    self.callback(requestToken: self.requestToken, oauthVerifier: oauthPin!)
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }.error { error in
                    
            }
            
        }
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    internal enum BrowserSignInError: Error {
        case noContent
        case parseError
    }
    
}


