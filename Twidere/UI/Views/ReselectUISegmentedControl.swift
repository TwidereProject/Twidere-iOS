//
//  ReselectUISegmentControl.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/20.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class ReselectUISegmentedControl: UISegmentedControl {
    
    var reselectAction: (() -> Void)!
    
    var previousSegmentIndex: Int = -1
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.previousSegmentIndex = self.selectedSegmentIndex
        super.touchesBegan(touches, with: event)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if (self.selectedSegmentIndex == self.previousSegmentIndex) {
            reselectAction?()
        }
        
        self.previousSegmentIndex = -1
    }
}
