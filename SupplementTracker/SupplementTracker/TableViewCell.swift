//
//  TableViewCell.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/5/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit
import QuartzCore
import CoreData


protocol TableViewCellDelegate{
    func supplementItemDeleted(supplementItem: NSManagedObject)
}


class TableViewCell: UITableViewCell {
    let gradientLayer = CAGradientLayer()
    var originalCenter = CGPoint()
    var deleteOnDragRelease = false, completeOnDragRelease = false
    var delegate: TableViewCellDelegate?
    var supplementItem: NSManagedObject? {
        didSet{
            let n = supplementItem!.valueForKey("name") as! String
            let d = supplementItem!.valueForKey("day") as! String
            label.strikeThrough = supplementItem!.valueForKey("completed") as! Bool
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
        
        label = StrikeThroughText(frame:CGRect.null)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(16)
        label.backgroundColor = UIColor.clearColor()
        
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        selectionStyle = .None
        
        gradientLayer.frame = bounds
        let color1 = UIColor(white: 1.0, alpha: 0.2).CGColor as CGColorRef
        let color2 = UIColor(white: 1.0, alpha: 0.1).CGColor as CGColorRef
        let color3 = UIColor.clearColor().CGColor as CGColorRef
        let color4 = UIColor(white: 0.0, alpha: 0.1).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2, color3, color4]
        gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
        layer.insertSublayer(gradientLayer, atIndex: 0)
        
        
        itemCompleteLayer = CALayer(layer:layer)
        itemCompleteLayer.backgroundColor = UIColor(red:0.0, green:0.6, blue:0.0, alpha: 0.9).CGColor
        print("itemCompleteLayer.hidden \(itemCompleteLayer.hidden)")
        itemCompleteLayer.hidden = true
        layer.insertSublayer(itemCompleteLayer, atIndex: 0)
        
        let recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
        
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
            deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
            completeOnDragRelease = frame.origin.x > frame.size.width / 2.0
        }
        
        if recognizer.state == .Ended {
            let originalFrame = CGRect(x:0, y:frame.origin.y, width: bounds.size.width, height: bounds.size.height)
            if deleteOnDragRelease{
                if delegate != nil && supplementItem != nil {
                    delegate!.supplementItemDeleted(supplementItem!)
                }
            } else if (completeOnDragRelease == true){
                if supplementItem != nil{
                    supplementItem?.setValue(true, forKey: "completed")
                }
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

