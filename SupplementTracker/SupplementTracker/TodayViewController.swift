//
//  TodayViewController.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/10/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class TodayViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var tableView: UITableView!
    var supplementsArray = [NSManagedObject]()
    var exerciseArray = [NSManagedObject]()
    let DAO = CoreDataDAO()
    
    
    override func viewDidLoad() {
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
        let managedContext = appDelegate.managedObjectContext
        
        // Load supplement data
        DAO.listCurrentDayData(managedContext, entityname: "Supplement")
        
        
        // Load exercise data
        DAO.listCurrentDayData(managedContext, entityname: "Exercise")
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int{
        switch section{
            case 0:
                print("supplementArray.count \(supplementsArray.count)")
                return supplementsArray.count
            case 1:
                print("exerciseArray.count \(exerciseArray.count)")
                return exerciseArray.count
            default:
                return 1
        }
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
            case 0:
                return "Supplements"
            case 1:
                return "Exercises"
            default:
                return "default"
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell!
        
        let supplement = supplementsArray[indexPath.row]
        //let exercise = exerciseArray[indexPath.row]
        
        cell?.backgroundColor = UIColor.grayColor()
        cell?.selectionStyle = .Gray
        cell?.supplementItem = supplement
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ShowNotesTrackerSegue", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let secondViewContoller = segue.destinationViewController as! NotesTrackerViewController
    }
}
