//
//  Utilities.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/14/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit

extension UIViewController{
    func hideKeyboardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
}
extension NSDate{
    func dayOfWeek() ->Int? {
        if
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Weekday, fromDate:self){
            return comp.weekday
        } else{
            return nil
        }
    }
}
func todayTitle() -> String{
    let currentDate = NSDate()
    let dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale.currentLocale()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    dateFormatter.dateFormat = "EEE, MMM dd"
    let convertedDate = dateFormatter.stringFromDate(currentDate)
    return convertedDate;
}
func getCurrentDay() -> String {
    var weekdayList: [String] = ["Sun","Mon","Tue","Wed","Thur","Fri","Sat"]
    
    switch NSDate().dayOfWeek()!
    {
    case 1: return weekdayList[0];
    case 2: return weekdayList[1];
    case 3: return weekdayList[2];
    case 4: return weekdayList[3];
    case 5: return weekdayList[4];
    case 6: return weekdayList[5];
    case 7: return weekdayList[6];
    default: return ""
    }
}

extension UIColor{
    
    static func nutrimentsPrimaryBlue() -> UIColor{
        return UIColor(red: 30/255, green: 151/255, blue: 240/255, alpha: 1.0)
    }
    static func nutrimentsAccentGreen() -> UIColor{
        return UIColor(red: 160/255, green: 212/255, blue: 104/255, alpha: 1.0)
    }
    static func nutrimentsAccentOrange() -> UIColor{
        return UIColor(red: 233/255, green: 87/255, blue: 63/255, alpha: 1.0)
    }
}