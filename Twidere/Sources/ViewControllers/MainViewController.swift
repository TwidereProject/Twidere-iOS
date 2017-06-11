//
// Created by Mariotaku Lee on 2017/6/10.
// Copyright (c) 2017 Mariotaku Dev. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let navController = UINavigationController()
        navController.viewControllers = [SignInViewController(nibName: nil, bundle: nil)]
        show(navController, sender: self)
    }


}
