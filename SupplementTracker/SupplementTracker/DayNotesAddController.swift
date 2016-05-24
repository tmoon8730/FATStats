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

class DayNotesAddController: UIViewController{
    @IBOutlet var noteText: UITextField!

    var DAO = CoreDataDAO()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func saveButton(sender: AnyObject) {
        DAO.saveData(appDelegate.managedObjectContext, entityName: "DayNotes", day: todayTitle(), notes: noteText.text!)
        print("Saved note of \(noteText.text!)")
        self.navigationController?.popViewControllerAnimated(true)
    }
    

}
