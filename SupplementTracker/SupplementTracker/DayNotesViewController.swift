//
//  DayNotesViewController.swift
//  Nutriments
//
//  Created by Tyler Moon on 5/18/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DayNotesViewController: EditViewController{
    
    override func viewDidLoad() {
        tableView.registerClass(DayNotesTableViewCell.self, forCellReuseIdentifier: "NoteCell")
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
        let managedContext = appDelegate.managedObjectContext
        
        // Load the list of objects for the entity
        displayObjectsArray = DAO.listAllData(managedContext, entityName: entityToSave)
        print("daynotesviewcontroller \(displayObjectsArray.count)")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell") as! DayNotesTableViewCell
        
        let displayObject = displayObjectsArray[indexPath.row]
        
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None
        cell.supplementItem = displayObject
        print("\(displayObject.valueForKey("day")) \(displayObject.valueForKey("notes"))")
        return cell
    }
}