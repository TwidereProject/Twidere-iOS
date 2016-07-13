//
//  ComposeController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import STPopup

class ComposeController: UIViewController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.title = "Compose"
        self.contentSizeInPopup = CGSizeMake(300, 240)
        self.landscapeContentSizeInPopup = CGSizeMake(400, 200)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    static func show(parent: UIViewController, identifier: String) {
        let root = parent.storyboard?.instantiateViewControllerWithIdentifier(identifier)
        let controller = STPopupController(rootViewController: root)
        controller.containerView.layer.cornerRadius = 4;

        controller.presentInViewController(parent)
    }

}
