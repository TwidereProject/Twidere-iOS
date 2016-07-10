//
//  ModelConverter.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Just

class ModelConverter {
    
    static func oauthToken(result: HTTPResult!) -> OAuthToken {
        var oauthToken = "", oauthTokenSecret = "", userId = "", screenName = ""
        for paramString in (result.text?.componentsSeparatedByString("&"))! {
            if (paramString.containsString("=")) {
                let param = paramString.componentsSeparatedByString("=").map({ (s) -> String in
                    return s.stringByRemovingPercentEncoding!
                })
                if (param.count == 2) {
                    switch (param[0]) {
                    case "oauth_token":
                        oauthToken = param[1]
                    case "oauth_token_secret":
                        oauthTokenSecret = param[1]
                    case "user_id":
                        userId = param[1]
                    case "screen_name":
                        screenName = param[1]
                    default: break
                    }
                }
            }
        }
        let token = OAuthToken(oauthToken: oauthToken, oauthTokenSecret: oauthTokenSecret)
        token.userId = userId
        token.screenName = screenName
        return token
    }
}