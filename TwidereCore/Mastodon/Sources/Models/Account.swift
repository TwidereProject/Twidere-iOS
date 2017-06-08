//
//  MastodonAccount.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/2.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery: jsonParse
// sourcery: extraImports=RestCommons
public class Account {
    /**
     * The ID of the account
     */
    //sourcery: jsonField=id
    public var id: String!
    /**
     * The username of the account
     */
    //sourcery: jsonField=username
    public var username: String!
    /**
     * Equals `username` for local users, includes `@domain` for remote ones
     */
    //sourcery: jsonField=acct
    public var acct: String!
    /**
     * The account's display name
     */
    //sourcery: jsonField=display_name
    public var displayName: String!
    /**
     * Boolean for when the account cannot be followed without waiting for approval first
     */
    //sourcery: jsonField=locked
    public var locked: Bool = false
    /**
     * The time the account was created
     */
    //sourcery: jsonField=created_at
    // sourcery: jsonFieldConverter=ISO8601DateFieldConverter
    public var createdAt: Date!
    /**
     * The number of followers for the account
     */
    //sourcery: jsonField=followers_count
    public var followersCount: Int64 = 0
    /**
     * The number of accounts the given account is following
     */
    //sourcery: jsonField=following_count
    public var followingCount: Int64 = 0
    /**
     * The number of statuses the account has made
     */
    //sourcery: jsonField=statuses_count
    public var statusesCount: Int64 = 0
    /**
     * Biography of user
     */
    //sourcery: jsonField=note
    public var note: String!
    /**
     * URL of the user's profile page (can be remote)
     */
    //sourcery: jsonField=url
    public var url: String!
    /**
     * URL to the avatar image
     */
    //sourcery: jsonField=avatar
    public var avatar: String!
    /**
     * URL to the avatar static image (gif)
     */
    //sourcery: jsonField=avatar_static
    public var avatarStatic: String!
    /**
     * URL to the header image
     */
    //sourcery: jsonField=header
    public var header: String!
    /**
     * URL to the header static image (gif)
     */
    //sourcery: jsonField=header_static
    public var headerStatic: String!

    required public init() {

    }
}
