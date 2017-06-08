//
//  AbsAccountRequestTask.swift
//  TwidereCore
//
//  Created by Mariotaku Lee on 2017/6/7.
//  Copyright © 2017年 Mariotaku Lee. All rights reserved.
//

import PromiseKit

open class AbsAccountRequestTask<Params, Result, Callback : AnyObject> : AbstractTask<Params, Result, Callback> {
    
    internal(set) public var accountKey: UserKey!
    
    public init(accountKey: UserKey!) {
        self.accountKey = accountKey
    }
    
    override open func createTaskPromise() -> Promise<Result> {
        return DispatchQueue.global().promise { () -> AccountDetails in
            guard let key = self.accountKey, let account = AccountDetails.get(key) else {
                throw TwidereError.accountNotFound
            }
            return account
        }.then(execute: createTaskPromise)
    }
    
    open func createTaskPromise(account: AccountDetails) -> Promise<Result> {
        return Promise(error: AbstractTaskError.notImplemented)
    }
    
    
    open func onCleanup(account: AccountDetails, params: Params, result: Result?, error: Error?) {
        if let result = result {
            onCleanup(account: account, params: params, result: result)
        } else if let error = error {
            onCleanup(account: account, params: params, error: error)
        }
    }
    
    open func onCleanup(account: AccountDetails, params: Params, result: Result) {}
    open func onCleanup(account: AccountDetails, params: Params, error: Error) {}
    
    open func createDraft() -> Draft? {
        return nil
    }
    
    open func deleteDraftOnError(account: AccountDetails, params: Params, error: Error) -> Bool {
        return false
    }
    
    override open func onError(callback: Callback?, error: Error) {
        
    }
}
