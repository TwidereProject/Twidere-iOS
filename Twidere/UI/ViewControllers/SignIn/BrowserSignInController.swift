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
        _ = navigationController?.popViewController(animated: true)
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
                    callback?(self.requestToken, nil)
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            
             firstly { () -> Promise<String> in
                return Promise<String> { fullfill, reject in
                    if let html = webView.stringByEvaluatingJavaScript(from: "document.body.innerHTML") {
                        fullfill(html)
                    } else {
                        reject(BrowserSignInError.noContent)
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


