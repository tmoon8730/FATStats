//
//  AddSupplementViewController.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/9/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit

@IBDesignable
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
    
    var supplementName: String!
    var supplementDay: String!
    var supplementNotes: String!
    var supplementCompleted: Bool = false
    var editFlag: Bool = false
    
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
    
    
        if(editFlag){
            if(supplementDay.containsString("Mon")){mondayButton.selected = true}
            if(supplementDay.containsString("Tue")){tuesdayButton.selected = true}
            if(supplementDay.containsString("Wed")){wednesdayButton.selected = true}
            if(supplementDay.containsString("Thur")){thursdayButton.selected = true}
            if(supplementDay.containsString("Fri")){fridayButton.selected = true}
            if(supplementDay.containsString("Sat")){saturdayButton.selected = true}
            if(supplementDay.containsString("Sun")){sundayButton.selected = true}
            
            nameTextField.text! = supplementName
            notesTextField.text! = supplementNotes
        }

    
    }
    func buttonClicked(sender:UIButton){
        sender.selected = !sender.selected
    }
    @IBAction func saveSupplement(sender: AnyObject) {
        
        let managedContext = appDelegate.managedObjectContext
        if(!editFlag){
            supplementDay = ""
            supplementName = nameTextField.text!
            supplementNotes = notesTextField.text!
            if(mondayButton.selected == true){supplementDay = supplementDay + "Mon"}
            if(tuesdayButton.selected == true){supplementDay = supplementDay + "Tue"}
            if(wednesdayButton.selected == true){supplementDay = supplementDay + "Wed"}
            if(thursdayButton.selected == true){supplementDay = supplementDay + "Thur"}
            if(fridayButton.selected == true){supplementDay = supplementDay + "Fri"}
            if(saturdayButton.selected == true){supplementDay = supplementDay + "Sat"}
            if(sundayButton.selected == true){supplementDay = supplementDay + "Sun"}
        }
        DAO.saveData(managedContext, entityName: "Supplement", name: supplementName, day: supplementDay, notes: supplementNotes, completed: supplementCompleted)
        print("Saved the data")
    }
}
