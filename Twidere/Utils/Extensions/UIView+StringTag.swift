//
//  UIView+StringTag.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/1.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var stringTag: String? {
        get {
            if (self.tag == 0 || self.tag < 0 || self.tag >= UIView.tagPoll.count) {
                return nil
            } else {
                return UIView.tagPoll.filter { (k, v) -> Bool in
                    return v == self.tag
                }.first?.0
            }
        }
        set {
            if (newValue == nil) {
                self.tag = 0
            } else {
                if let intTag = UIView.tagPoll[newValue!] {
                    self.tag = intTag
                } else {
                    let newTag = UIView.tagPoll.count + 1
                    UIView.tagPoll[newValue!] = newTag
                    self.tag = newTag
                }
            }
        }
    }
    
    func viewWithStringTag(stringTag: String) -> UIView? {
        guard let intTag = UIView.tagPoll[stringTag] else {
            return nil
        }
        return viewWithTag(intTag)
    }

    private static var tagPoll = [String: Int]()
}
