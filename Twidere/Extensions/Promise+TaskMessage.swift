//
//  Promise+TaskMessage.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import PromiseKit
import JDStatusBarNotification

extension Promise {
    func showStatusBarNotificationAfterTask(success: String, failure: String) {
        self.then { _ -> Void in
            JDStatusBarNotification.show(withStatus: success, dismissAfter: 1.5, styleName: JDStatusBarStyleSuccess)
        }.catch { error in
            if (error.isCancelledError) {
                return
            }
            JDStatusBarNotification.show(withStatus: failure, dismissAfter: 1.5, styleName: JDStatusBarStyleError)
        }
        
    }
}
