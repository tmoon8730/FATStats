//
//  AddSupplementViewController.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/9/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit

class AddSupplementViewController: UIViewController {
    
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let DAO = CoreDataDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mondayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        tuesdayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        wednesdayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        thursdayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        fridayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        saturdayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        sundayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    func buttonClicked(sender:UIButton){
        sender.selected = !sender.selected
    }
    @IBAction func saveSupplement(sender: AnyObject) {
        
        let managedContext = appDelegate.managedObjectContext
        
        let supplementName = nameTextField.text!
        var day: String = ""
        if(mondayButton.selected == true){
            day = day + "Mon"
        }
        if(tuesdayButton.selected == true){
            day = day + "Tue"
        }
        if(wednesdayButton.selected == true){
            day = day + "Wed"
        }
        if(thursdayButton.selected == true){
            day = day + "Thur"
        }
        if(fridayButton.selected == true){
            day = day + "Fri"
        }
        if(saturdayButton.selected == true){
            day = day + "Sat"
        }
        if(sundayButton.selected == true){
            day = day + "Sun"
        }
        let supplementNotes = notesTextField.text!
        
        DAO.saveData(managedContext, entityName: "Supplement", name: supplementName, day: day, notes: supplementNotes, completed: false)
        print("Saved the data")
    }
}
