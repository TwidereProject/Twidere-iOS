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
    var callback: ((requestToken: OAuthToken, oauthVerifier: String?) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let endpoint = customAPIConfig.createEndpoint("api", noVersionSuffix: true)
        let requestUrl = endpoint.constructUrl("/oauth/authorize", queries: ["oauth_token": requestToken.oauthToken])
        let request = NSURLRequest(URL: NSURL(string: requestUrl)!)
        webView.loadRequest(request)
        webView.delegate = self
    }
    
    @IBAction func cancelBrowserSignIn(sender: UIBarButtonItem) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        guard let request = webView.request else {
            return
        }
        guard let url = request.URL else {
            return
        }
        if (url.host == "fanfou.com") {
            if (url.path == "/oauth/authorize") {
                let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: true)
                
                let oauthCallbackIndex = components?.queryItems?.indexOf { item -> Bool in
                    return item.name == "oauth_callback"
                }
                if (oauthCallbackIndex != nil) {
                    callback(requestToken: self.requestToken, oauthVerifier: nil)
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
        } else {
            
             let oauthPin = firstly { () -> Promise<String> in
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
            }.then { doc throws -> String in
                let numericSet = NSCharacterSet.decimalDigitCharacterSet().invertedSet
                guard let oauthPin = doc.at_css("div#oauth_pin")?.css("*").filter({ (child) -> Bool in
                    if (child.text == nil) {
                        return false
                    }
                    return child.text!.rangeOfCharacterFromSet(numericSet) == nil
                }).first?.text else {
                    throw BrowserSignInError.NoOAuthPin
                }
                return oauthPin
            }.value
            if (oauthPin != nil) {
                callback(requestToken: self.requestToken, oauthVerifier: oauthPin)
                navigationController?.popViewControllerAnimated(true)
            }
            
        }
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    internal enum BrowserSignInError: ErrorType {
        case NoContent
        case ParseError
        case NoOAuthPin
    }
    
}


