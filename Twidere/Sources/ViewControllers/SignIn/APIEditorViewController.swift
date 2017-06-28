//
// Created by Mariotaku Lee on 2017/6/15.
// Copyright (c) 2017 Mariotaku Dev. All rights reserved.
//

import Eureka
import TwidereCore

class APIEditorViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit API"

        navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .cancel, target: self,
                action: #selector(cancelEditing)), animated: false)

        self.setupForm()
    }

    private func setupForm() {
        form.append(Section { section in
            section.append(TextRow("api_url_format") { row in
                row.title = "API URL format"
            })
            section.append(PickerInputRow<AccountDetails.AccountType>("account_type") { row in
                row.title = "Account type"
                row.options = [.twitter, .fanfou, .statusnet, .mastodon]
                row.value = .twitter
            })
        })
        form.append(Section { section in
            section.append(PickerInputRow<AccountDetails.CredentialsType>("auth_type") { row in
                row.title = "Auth type"
                row.options = [.oauth, .oauth2, .xauth, .basic, .empty]
                row.value = .oauth
            })
            let twitterFeatureHidden = Condition.function(["account_type"]) { form in
                let accountType = (form.rowBy(tag: "account_type") as! PickerInputRow<AccountDetails.AccountType>).value
                return accountType != .twitter
            }

            section.append(SwitchRow("same_signing_url") { (row: SwitchRow) in
                row.title = "Same OAuth signing url"
                row.hidden = twitterFeatureHidden
            })
            section.append(SwitchRow("no_version_suffix") { (row: SwitchRow) in
                row.title = "No version suffix"
                row.hidden = twitterFeatureHidden
            })

        })
        form.append(Section { section in
            section.append(TextRow("consumer_key") { row in
                row.title = "Consumer key"
            })
            section.append(TextRow("consumer_secret") { row in
                row.title = "Consumer secret"
            })

            section.hidden = .function(["auth_type"]) { form in
                let authType = (form.rowBy(tag: "auth_type") as! PickerInputRow<AccountDetails.CredentialsType>).value
                return authType != .oauth && authType != .xauth
            }
        })

    }

    @objc private func cancelEditing() {
        dismiss(animated: true)
    }
}

extension AccountDetails.AccountType: InputTypeInitiable, CustomStringConvertible {
    public init?(string stringValue: String) {
        switch stringValue {
        case "twitter": self = .twitter
        case "fanfou": self = .fanfou
        case "statusnet": self = .statusnet
        case "mastodon": self = .mastodon
        default: return nil
        }
    }

    public var description: String {
        switch self {
        case .twitter: return "Twitter"
        case .fanfou: return "Fanfou"
        case .statusnet: return "StatusNet"
        case .mastodon: return "Mastodon"
        }
    }
}


extension AccountDetails.CredentialsType: InputTypeInitiable, CustomStringConvertible {
    public init?(string stringValue: String) {
        switch stringValue {
        case "oauth": self = .oauth
        case "oauth2": self = .oauth2
        case "xauth": self = .xauth
        case "basic": self = .basic
        case "empty": self = .empty
        default: return nil
        }
    }

    public var description: String {
        switch self {
        case .oauth: return "OAuth"
        case .oauth2: return "OAuth 2"
        case .xauth: return "xAuth"
        case .basic: return "Basic"
        case .empty: return "Empty"
        }
    }
}
