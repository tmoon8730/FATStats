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
        //tableView.registerClass(DayNotesTableViewCell.self, forCellReuseIdentifier: "NoteCell")
        tableView.reloadData()
        self.tableView.rowHeight = 210
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(DayNotesViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
        let managedContext = appDelegate.managedObjectContext
        
        // Load the list of objects for the entity
        displayObjectsArray = DAO.listAllData(managedContext, entityName: entityToSave)
       // displayObjectsArray.sort{ $0.name.compare($1.name) == NSComparisonResult.OrderedDescending }
        print("daynotesviewcontroller \(displayObjectsArray.count)")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayObjectsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell") as! DayNotesTableViewCell
        
        let displayObject = displayObjectsArray[indexPath.row]
        
        let day = displayObject.valueForKey("day") as? String
        let supplementDay = "Supplements for " + day!
        let exerciseDay = "Exercise for " + day!
        
        cell.backgroundColor = UIColor.clearColor()
        cell.dayLabel.text = displayObject.valueForKey("day") as? String
        cell.noteLabel.text = displayObject.valueForKey("notes") as? String
        cell.supplementLabel.text = supplementDay
        cell.completedSupplements.text = displayObject.valueForKey("completedSupplements") as? String
        cell.exerciseLabel.text = exerciseDay
        cell.completedExercises.text = displayObject.valueForKey("completedExercises") as? String
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func refresh(sender: AnyObject){
        let managedContext = appDelegate.managedObjectContext
        
        displayObjectsArray = DAO.listAllData(managedContext, entityName: entityToSave)
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}