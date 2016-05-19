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
            let n = supplementItem!.valueForKey("notes") as! String
            let d = supplementItem!.valueForKey("day") as! String
            label.strikeThrough = false
            print("didSet label.strikeThrough \(label.strikeThrough)")
            let labelText:String = ("\(n) , \(d)")
            label.text = labelText
            label.strikeThrough = false
            itemCompleteLayer.hidden = true
        }
    }
    let label: StrikeThroughText
    var itemCompleteLayer = CALayer()
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        label = StrikeThroughText(frame:CGRect.null) // Creates a new object of the custom class StrikeThroughText
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(16)
        label.backgroundColor = UIColor.clearColor()
        
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        selectionStyle = .None
        
               
        // Item complete layer adds a green overly to the cell
        itemCompleteLayer = CALayer(layer:layer)
        itemCompleteLayer.backgroundColor = UIColor(red:0.0, green:0.6, blue:0.0, alpha: 0.9).CGColor
        itemCompleteLayer.hidden = true
        layer.insertSublayer(itemCompleteLayer, atIndex: 0)
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(TableViewCell.handlePan(_:)))
        recognizer.delegate = self
        addGestureRecognizer(recognizer) // Gesture reconginzer for determining when the cell is swiped right
        
    }
    
    let kLabelLeftMargin: CGFloat = 15.0
    override func layoutSubviews(){
        super.layoutSubviews()
        gradientLayer.frame = bounds
        itemCompleteLayer.frame = bounds
        label.frame = CGRect(x: kLabelLeftMargin, y:0, width:bounds.size.width - kLabelLeftMargin, height: bounds.size.height)
    }
    
    
    func handlePan(recognizer: UIPanGestureRecognizer){
        if recognizer.state == .Began {
            originalCenter = center
        }
        if recognizer.state == .Changed{
            let translation = recognizer.translationInView(self)
            center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
            completeOnDragRelease = frame.origin.x > frame.size.width / 2.0 // If the cell has moved more than halfway to the right then trigger the green background and strikethrough text
        }
        
        if recognizer.state == .Ended {
            let originalFrame = CGRect(x:0, y:frame.origin.y, width: bounds.size.width, height: bounds.size.height)
            if (completeOnDragRelease == true){
                label.strikeThrough = true
                itemCompleteLayer.hidden = false
                print("Setting completeItem")
                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
            } else {
                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
            }
        }
    }
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }

}
