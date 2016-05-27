//
//  TableViewCell.swift
//  SupplementTracker
//
//  This class overrides the default table cell and adds in the ability to swipe to complete a task
//
//
//  Created by Tyler Moon on 5/5/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit
import QuartzCore
import CoreData


class TableViewCell: UITableViewCell {
    
    // Variables to handle the strike through and green background
    let gradientLayer = CAGradientLayer()
    var originalCenter = CGPoint()
    var completeOnDragRelease = false
    var supplementItem: NSManagedObject? {
        didSet{
            let n = supplementItem!.valueForKey("name") as! String
            let d = supplementItem!.valueForKey("day") as! String
            let labelText:String = ("\(n) , \(d)")
            label.text = labelText
            itemCompleteLayer.hidden = true
        }
    }
    let label: UILabel = UILabel()
    var itemCompleteLayer = CALayer()
    

    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
}

