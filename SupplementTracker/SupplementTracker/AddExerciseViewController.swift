//
//  AddExerciseViewController.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/9/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit

class AddExerciseViewController: UIViewController{
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    
    var exerciseName: String!
    var exerciseDay: String!
    var exerciseNotes: String!
    var exerciseCompleted: Bool = false
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
            if(exerciseDay.containsString("Mon")){mondayButton.selected = true}
            if(exerciseDay.containsString("Tue")){tuesdayButton.selected = true}
            if(exerciseDay.containsString("Wed")){wednesdayButton.selected = true}
            if(exerciseDay.containsString("Thur")){thursdayButton.selected = true}
            if(exerciseDay.containsString("Fri")){fridayButton.selected = true}
            if(exerciseDay.containsString("Sat")){saturdayButton.selected = true}
            if(exerciseDay.containsString("Sun")){sundayButton.selected = true}
            
            nameTextField.text! = exerciseName
            notesTextField.text! = exerciseNotes
        }
        
        
    }
    func buttonClicked(sender:UIButton){
        sender.selected = !sender.selected
    }
    @IBAction func saveSupplement(sender: AnyObject) {
        
        let managedContext = appDelegate.managedObjectContext
        if(!editFlag){
            exerciseDay = ""
            exerciseName = nameTextField.text!
            exerciseNotes = notesTextField.text!
            if(mondayButton.selected == true){exerciseDay = exerciseDay + "Mon"}
            if(tuesdayButton.selected == true){exerciseDay = exerciseDay + "Tue"}
            if(wednesdayButton.selected == true){exerciseDay = exerciseDay + "Wed"}
            if(thursdayButton.selected == true){exerciseDay = exerciseDay + "Thur"}
            if(fridayButton.selected == true){exerciseDay = exerciseDay + "Fri"}
            if(saturdayButton.selected == true){exerciseDay = exerciseDay + "Sat"}
            if(sundayButton.selected == true){exerciseDay = exerciseDay + "Sun"}
        }
        DAO.saveData(managedContext, entityName: "Exercise", name: exerciseName, day: exerciseDay, notes: exerciseNotes, completed: exerciseCompleted)
        print("Saved the data")
    }


}