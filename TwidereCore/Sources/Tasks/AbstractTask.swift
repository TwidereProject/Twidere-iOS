//
//  AbstractTask.swift
//  TwidereCore
//
//  Created by Mariotaku Lee on 2017/6/6.
//  Copyright © 2017年 Mariotaku Lee. All rights reserved.
//

import PromiseKit

open class AbstractTask<Params, Result, Callback : AnyObject> {
    
    public weak var callback: Callback!
    
    public var params: Params!
    
    public func execute() -> Promise<Result> {
        beforeExecute()
        let tp = createTaskPromise()
        return tp.then { result -> Result in
            self.afterExecute(callback: self.callback, result: result, error: nil)
            self.onSucceed(callback: self.callback, result: result)
            return result
        }.catch { error in
            self.afterExecute(callback: self.callback, result: nil, error: error)
            self.onError(callback: self.callback, error: error)
        }
    }
    
    open func createTaskPromise() -> Promise<Result> {
        return Promise(error: AbstractTaskError.notImplemented)
    }
    
    open func beforeExecute() {
        
    }
    
    open func afterExecute(callback: Callback!, result: Result!, error: Error!) {
        
    }
    
    open func onSucceed(callback: Callback?, result: Result) {
    }
    
    open func onError(callback: Callback?, error: Error) {
    }
    
}

public enum AbstractTaskError: Error {
    case notImplemented
}
