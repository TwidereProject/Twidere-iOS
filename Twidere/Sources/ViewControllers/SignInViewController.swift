//
// Created by Mariotaku Lee on 2017/6/10.
// Copyright (c) 2017 Mariotaku Dev. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import ALSLayouts

class SignInViewController: UIViewController {

    lazy var signInView: UIView = SignInView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(signInView)
        signInView.snp.makeConstraints { maker in
            maker.width.equalTo(self.view)
            maker.top.equalTo(self.topLayoutGuide.snp.bottom)
            maker.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
        }
        let rightItems = [
                UIBarButtonItem(image: UIImage(named: "Toolbar Settings"), landscapeImagePhone: nil, style: .plain,
                        target: nil, action: nil)
        ]
        navigationItem.title = "Login"
        navigationItem.setRightBarButtonItems(rightItems, animated: false)
    }

}

class SignInView: ALSFrameLayout {

    let editUsername = UITextField()
    let signInButton = UIButton(type: .system).also { it in
        it.setTitle("Login", for: .normal)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false

        let container = ALSLinearLayout().also { it in
            it.isOpaque = false
            it.orientation = .Vertical
            it.gravity = ALSGravity.CENTER
        }

        container.addSubview(editUsername) { params in
            params.widthMode = .MatchParent
            params.heightMode = .WrapContent
        }

        container.addSubview(signInButton) { params in
            params.widthMode = .MatchParent
            params.heightMode = .WrapContent
        }

        self.addSubview(container) { params in
            params.widthMode = .StaticSize
            params.heightMode = .WrapContent
            params.width = 300
            params.gravity = ALSGravity.CENTER
        }

    }

}