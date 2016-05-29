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
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var noteLabel: UITextView!
    @IBOutlet weak var supplementLabel: UILabel!
    @IBOutlet weak var completedSupplements: UITextView!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var completedExercises: UITextView!
    
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
