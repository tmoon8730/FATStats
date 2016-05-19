//
//  DayNotesTableViewCell.swift
//  Nutriments
//
//  Created by Tyler Moon on 5/18/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit
import CoreData

class DayNotesTableViewCell: UITableViewCell{
    
    // Variables to handle the strike through and green background
    let gradientLayer = CAGradientLayer()
    var originalCenter = CGPoint()
    var completeOnDragRelease = false
    var supplementItem: NSManagedObject? {
        didSet{
            let n = supplementItem!.valueForKey("day") as! String
            let d = supplementItem!.valueForKey("notes") as! String
            let labelText:String = ("\(n) , \(d)")
            label.text = labelText
        }
    }
    let label: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        label = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
}
