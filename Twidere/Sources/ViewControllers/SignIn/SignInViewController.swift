//
// Created by Mariotaku Lee on 2017/6/10.
// Copyright (c) 2017 Mariotaku Dev. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import ALSLayouts

class SignInViewController: UIViewController {

    var cancellable: Bool = false

    lazy var signInView: UIView = SignInView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(signInView)
        signInView.snp.makeConstraints { maker in
            maker.width.equalTo(self.view)
            maker.top.equalTo(self.topLayoutGuide.snp.bottom)
            maker.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
        }

        title = "Login"

        if (cancellable) {
            navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil),
                    animated: false)
        }

        let rightItems = [
                UIBarButtonItem(image: UIImage(named: "Toolbar Settings"), landscapeImagePhone: nil, style: .plain,
                        target: self, action: #selector(openSettings)),
                UIBarButtonItem(title: "API", style: .plain,
                        target: self, action: #selector(openAPIConfig)),
        ]
        navigationItem.setRightBarButtonItems(rightItems, animated: false)
    }

    @objc private func openAPIConfig() {
        let vc = UINavigationController().also { it in
            it.modalPresentationStyle = .popover
            it.setViewControllers([APIEditorViewController()], animated: false)
        }
        self.present(vc, animated: true)
    }

    @objc private func openSettings() {

    }

}

class SignInView: ALSFrameLayout {

    let editUsername = UITextField().also { it in
        it.placeholder = "Username"
        it.layer.borderColor = UIColor.black.cgColor
        it.borderStyle = .roundedRect
    }

    let editPassword = UITextField().also { it in
        it.placeholder = "Password"
        it.isSecureTextEntry = true
        it.borderStyle = .roundedRect
    }

    let signInButton = UIButton(type: .system).also { it in
        it.setTitle("Login", for: .normal)
    }

    let signUpButton = UIButton(type: .system).also { it in
        it.setTitle("Sign up", for: .normal)
    }

    let passwordSignInButton = UIButton(type: .system).also { it in
        it.setTitle("Password sign in", for: .normal)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false

        let container = ALSLinearLayout().also { it in
            it.isOpaque = false
            it.orientation = .vertical
            it.gravity = ALSGravity.CENTER
        }

        container.addSubview(editUsername) { params in
            params.width = .matchParent
            params.height = .wrapContent
        }

        container.addSubview(editPassword) { params in
            params.width = .matchParent
            params.height = .wrapContent
            params.marginTop = 8
        }

        container.addSubview(signInButton) { params in
            params.width = .matchParent
            params.height = .wrapContent
        }

        container.addSubview(signUpButton) { params in
            params.width = .matchParent
            params.height = .wrapContent
        }

        container.addSubview(passwordSignInButton) { params in
            params.width = .matchParent
            params.height = .wrapContent
        }

        self.addSubview(container) { params in
            params.width = .staticSize(300)
            params.height = .wrapContent
            params.gravity = ALSGravity.CENTER
        }

    }

}