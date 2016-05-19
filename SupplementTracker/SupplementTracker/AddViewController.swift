//
//  AddViewController.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/14/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable


class AddViewController: UIViewController{
    // Outlets for the day of the week selection buttons
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var selectAllButton: UIButton!
    // Outlets for the text fields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!

    // These variables are set in the storyboard on the ViewController
    @IBInspectable var selectionColor: UIColor!
    @IBInspectable var nonSelectionColor: UIColor!
    @IBInspectable var entityToSave: String!
    @IBInspectable var viewTitle: String!
    
    // These variables are used when setting the fields from the EditViewController
    var addName: String!
    var addDay: String!
    var addNotes: String!
    var addCompleted: Bool = false
    var editFlag: Bool = false
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let DAO = CoreDataDAO() // Database Access Object
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewTitle
        
        self.hideKeyboardWhenTappedAround()
        
        // Action selectors for all the day of the week buttons. When the button is pressed the buttonClicked method is called
        mondayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        tuesdayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        wednesdayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        thursdayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        fridayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        saturdayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        sundayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        selectAllButton.addTarget(self, action: #selector(AddViewController.selectAllButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        // Sets all the day of the week buttons so have the nonSelectionColor set in the storyboard
        mondayButton.backgroundColor = nonSelectionColor
        tuesdayButton.backgroundColor = nonSelectionColor
        wednesdayButton.backgroundColor = nonSelectionColor
        thursdayButton.backgroundColor = nonSelectionColor
        fridayButton.backgroundColor = nonSelectionColor
        saturdayButton.backgroundColor = nonSelectionColor
        sundayButton.backgroundColor = nonSelectionColor
        selectAllButton.backgroundColor = nonSelectionColor
        
        // If the edit flag is true that means the method was called from the EditViewController. If the addDay variable contains the code for
        // a day of the week then that button is set to selected
        if(editFlag){
            if(addDay.containsString("Mon")){mondayButton.selected = false}
            if(addDay.containsString("Tue")){tuesdayButton.selected = true}
            if(addDay.containsString("Wed")){wednesdayButton.selected = true}
            if(addDay.containsString("Thur")){thursdayButton.selected = true}
            if(addDay.containsString("Fri")){fridayButton.selected = true}
            if(addDay.containsString("Sat")){saturdayButton.selected = true}
            if(addDay.containsString("Sun")){sundayButton.selected = true}
            
            nameTextField.text! = addName
            notesTextField.text! = addNotes
        }
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(doneButtonTapped))
        
    }
    
    func doneButtonTapped(sender:UIButton){
        dismissKeyboard()
    }
    func buttonClicked(sender:UIButton){
        
        sender.selected = !sender.selected
        var button: UIButton
        if let b = sender as? UIButton{
            button = b
            if(button.selected == true){
                button.backgroundColor = selectionColor // The button has been selected
                
            }else{
                button.backgroundColor = nonSelectionColor // The button has not been selected
            }
        }
        
    }
    func selectAllButtonClicked(sender: UIButton){
        // Method for handling the select all button
        if(sender.selected == false){
            print("in true")
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
            // If the editFlag is false then this class was not called fromt he EditViewController so all the edit variables are not set yet
            addDay = ""
            addName = nameTextField.text!
            addNotes = notesTextField.text!
            if(mondayButton.selected == true){addDay = addDay + "Mon"}
            if(tuesdayButton.selected == true){addDay = addDay + "Tue"}
            if(wednesdayButton.selected == true){addDay = addDay + "Wed"}
            if(thursdayButton.selected == true){addDay = addDay + "Thur"}
            if(fridayButton.selected == true){addDay = addDay + "Fri"}
            if(saturdayButton.selected == true){addDay = addDay + "Sat"}
            if(sundayButton.selected == true){addDay = addDay + "Sun"}
        }
        DAO.saveData(managedContext, entityName: entityToSave, name: addName, day: addDay, notes: addNotes, completed: addCompleted) // Save a new entry into the CoreData database
        print("Saved the data")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
        self.title = self.viewTitle
    }
}
