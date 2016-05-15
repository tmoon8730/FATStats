//
//  AddExerciseViewController.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/9/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit
@IBDesignable
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
    @IBOutlet weak var selectAllButton: UIButton!
    
    @IBInspectable var selectionColor: UIColor!
    @IBInspectable var nonSelectionColor: UIColor!
    
    var exerciseName: String!
    var exerciseDay: String!
    var exerciseNotes: String!
    var exerciseCompleted: Bool = false
    var editFlag: Bool = false
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let DAO = CoreDataDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        mondayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        tuesdayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        wednesdayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        thursdayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        fridayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        saturdayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        sundayButton.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        selectAllButton.addTarget(self, action: "selectAllButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        mondayButton.backgroundColor = nonSelectionColor
        tuesdayButton.backgroundColor = nonSelectionColor
        wednesdayButton.backgroundColor = nonSelectionColor
        thursdayButton.backgroundColor = nonSelectionColor
        fridayButton.backgroundColor = nonSelectionColor
        saturdayButton.backgroundColor = nonSelectionColor
        sundayButton.backgroundColor = nonSelectionColor
        selectAllButton.backgroundColor = nonSelectionColor
        
        if(editFlag){
            if(exerciseDay.containsString("Mon")){mondayButton.selected = false}
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
        
       
        print("In buttonClicked with \(sender.selected)")
        var button: UIButton
        if let b = sender as? UIButton{
            button = b
            if(button.selected == true){
                button.backgroundColor = selectionColor
                
            }else{
                button.backgroundColor = nonSelectionColor
            }
        }
         sender.selected = !sender.selected
    }
    func selectAllButtonClicked(sender: UIButton){
        print("In selectAllButtonClicked")
        if(sender.selected == false){
            mondayButton.selected = false // These are false do too the flip on the buttonClicked function
            tuesdayButton.selected = false
            wednesdayButton.selected = false
            thursdayButton.selected = false
            fridayButton.selected = false
            saturdayButton.selected = false
            sundayButton.selected = false
        }else{
            mondayButton.selected = true
            tuesdayButton.selected = true
            wednesdayButton.selected = true
            thursdayButton.selected = true
            fridayButton.selected = true
            saturdayButton.selected = true
            sundayButton.selected = true
        }
        print("Monday button \(mondayButton.selected)")
        buttonClicked(mondayButton)
        buttonClicked(tuesdayButton)
        buttonClicked(wednesdayButton)
        buttonClicked(thursdayButton)
        buttonClicked(fridayButton)
        buttonClicked(saturdayButton)
        buttonClicked(sundayButton)
        buttonClicked(sender) // Sender is the select all button
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