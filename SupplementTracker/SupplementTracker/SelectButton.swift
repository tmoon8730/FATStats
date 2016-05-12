//
//  SelectButton.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/11/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit

@IBDesignable

class SelectButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawRect(rect: CGRect){
        var path = UIBezierPath(roundedRect: rect, cornerRadius: 10.5)
        UIColor.greenColor().setFill()
        path.fill()
    }

}
