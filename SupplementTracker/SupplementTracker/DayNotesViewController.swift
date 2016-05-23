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
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(DayNotesTableViewCell.self, forCellReuseIdentifier: "NoteCell")
        tableView.reloadData()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(DayNotesViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
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
        cell.label.textColor = UIColor.blackColor()
        cell.supplementItem = displayObject
        print("\(displayObject.valueForKey("day")) \(displayObject.valueForKey("notes"))")
        return cell
    }
    
    func refresh(sender: AnyObject){
        let managedContext = appDelegate.managedObjectContext
        
        displayObjectsArray = DAO.listAllData(managedContext, entityName: entityToSave)
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}