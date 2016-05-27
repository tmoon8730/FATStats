//
//  EditTableViewCell.swift
//  Nutriments
//
//  Created by Debbie Moon on 5/27/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import Foundation
import UIKit


class EditTableViewCell: UITableViewCell{
    
    @IBOutlet weak var editLabel: UILabel!
    
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