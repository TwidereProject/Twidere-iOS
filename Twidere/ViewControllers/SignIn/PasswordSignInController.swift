//
//  PasswordSignInController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class PasswordSignInController: UIViewController {
    
    @IBOutlet weak var editUsername: UITextField!
    @IBOutlet weak var editPassword: UITextField!

    var usernamePassword: (String, String) {
        get {
            let username = editUsername.text ?? ""
            let password = editPassword.text ?? ""
            return (username, password)
        }
    }

}
