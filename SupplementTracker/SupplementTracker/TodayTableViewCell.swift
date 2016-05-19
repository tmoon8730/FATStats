//
//  TodayTableViewCell.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/15/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit
import CoreData

class TodayTableViewCell: UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notesLabel: UITextView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
