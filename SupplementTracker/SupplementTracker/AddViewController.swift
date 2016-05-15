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
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!

    
    @IBInspectable var selectionColor: UIColor!
    @IBInspectable var nonSelectionColor: UIColor!
    @IBInspectable var entityToSave: String!
    @IBInspectable var viewTitle: String!
    
    var addName: String!
    var addDay: String!
    var addNotes: String!
    var addCompleted: Bool = false
    var editFlag: Bool = false
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let DAO = CoreDataDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewTitle
        
        self.hideKeyboardWhenTappedAround()
        
        mondayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        tuesdayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        wednesdayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        thursdayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        fridayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        saturdayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        sundayButton.addTarget(self, action:#selector(AddViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        selectAllButton.addTarget(self, action: #selector(AddViewController.selectAllButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        mondayButton.backgroundColor = nonSelectionColor
        tuesdayButton.backgroundColor = nonSelectionColor
        wednesdayButton.backgroundColor = nonSelectionColor
        thursdayButton.backgroundColor = nonSelectionColor
        fridayButton.backgroundColor = nonSelectionColor
        saturdayButton.backgroundColor = nonSelectionColor
        sundayButton.backgroundColor = nonSelectionColor
        selectAllButton.backgroundColor = nonSelectionColor
        
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
        
        
    }
    func buttonClicked(sender:UIButton){
        
        sender.selected = !sender.selected
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
        
    }
    func selectAllButtonClicked(sender: UIButton){
        print("In selectAllButtonClicked \(sender.selected)")
        if(/*sender.titleLabel == "Select All" &&*/ sender.selected == false){
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
        DAO.saveData(managedContext, entityName: entityToSave, name: addName, day: addDay, notes: addNotes, completed: addCompleted)
        print("Saved the data")
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
        self.title = self.viewTitle
    }

}