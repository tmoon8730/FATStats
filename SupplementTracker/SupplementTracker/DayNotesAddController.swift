//
//  DayNotesAddController.swift
//  Nutriments
//
//  Created by Tyler Moon on 5/23/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class DayNotesAddController: UIViewController, UITextFieldDelegate{
    @IBOutlet var noteText: UITextField!

    var DAO = CoreDataDAO()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func saveButton(sender: AnyObject) {
        let completedSupplements = DAO.completedItemsForToday(appDelegate.managedObjectContext, entityName: "Supplement")
        let completedExercises = DAO.completedItemsForToday(appDelegate.managedObjectContext, entityName: "Exercise")
        DAO.saveData(appDelegate.managedObjectContext, entityName: "DayNotes", day: todayTitle(), notes: noteText.text!, completedSupplements: completedSupplements, completedExercises: completedExercises)
        print("Saved note of \(noteText.text!)")
        self.navigationController?.popViewControllerAnimated(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        noteText.layer.borderColor = UIColor(red: 20/255, green: 126/255, blue: 240/255, alpha: 1.0).CGColor
        noteText.layer.borderWidth = 2.0
    }

}
