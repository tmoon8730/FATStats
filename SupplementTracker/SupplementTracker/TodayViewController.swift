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

class TodayViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notesTextView: UITextView!
    var supplementsArray = [NSManagedObject]()
    var exerciseArray = [NSManagedObject]()
    let DAO = CoreDataDAO()
    lazy var refreshControl: UIRefreshControl = UIRefreshControl()
    
    @IBAction func saveDayNote(sender: AnyObject) {
        let managedContext = appDelegate.managedObjectContext
        DAO.saveData(managedContext, entityName: "DayNotes", day: getCurrentDay(), notes: notesTextView.text!)
        print("Saved Note \(notesTextView.text!)")
        notesTextView.text = ""
        dismissKeyboard()
    }
    
    override func viewDidLoad() {
        //tableView.registerClass(TodayTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.title = todayTitle()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(TodayViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
        let managedContext = appDelegate.managedObjectContext
        
        // Load supplement data
        supplementsArray = DAO.listCurrentDayData(managedContext, entityname: "Supplement")
        
        
        // Load exercise data
        exerciseArray = DAO.listCurrentDayData(managedContext, entityname: "Exercise")
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TodayTableViewCell
        var supplement: NSManagedObject?
        switch indexPath.section{
        case 0:
            supplement = supplementsArray[indexPath.row]
            break;
        case 1:
            supplement = exerciseArray[indexPath.row]
            break;
        default:
            print("cellForRowAtIndexPath error")
            break;
        }
        cell.selectionStyle = .Gray
        cell.nameLabel.text = supplement!.valueForKey("name") as? String
        cell.notesLabel.text = supplement!.valueForKey("notes") as? String
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ShowNotesTrackerSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
      /*  if editingStyle == UITableViewCellEditingStyle.Delete {
            var deleteObject: NSManagedObject?
            var entityString: String = ""
            switch indexPath.section{
            case 0:
                deleteObject = supplementsArray.removeAtIndex(indexPath.row)
                entityString = "Supplement"
                break
            case 1:
                deleteObject = exerciseArray.removeAtIndex(indexPath.row)
                entityString = "Exercise"
                break
            default:
                break
            }
            DAO.deleteData(appDelegate.managedObjectContext, entitiyName: entityString, deleteItem: deleteObject!)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }*/
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let completeAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Completed", handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // Completed stuff
            print("In completed")
        })
        completeAction.backgroundColor = UIColor.greenColor()
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // Delete Stuff
            print("In delete")
            var deleteObject: NSManagedObject?
            var entityString: String = ""
            switch indexPath.section{
            case 0:
                deleteObject = self.supplementsArray.removeAtIndex(indexPath.row)
                entityString = "Supplement"
                break
            case 1:
                deleteObject = self.exerciseArray.removeAtIndex(indexPath.row)
                entityString = "Exercise"
                break
            default:
                break
            }
            self.DAO.deleteData(self.appDelegate.managedObjectContext, entitiyName: entityString, deleteItem: deleteObject!)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)

        })
        return [completeAction, deleteAction]
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
        self.title = todayTitle()
    }
    func refresh(sender:AnyObject){
        let managedContext = appDelegate.managedObjectContext
        // Load supplement data
        supplementsArray = DAO.listCurrentDayData(managedContext, entityname: "Supplement")
        
        
        // Load exercise data
        exerciseArray = DAO.listCurrentDayData(managedContext, entityname: "Exercise")
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool{
        if(text == "\n"){
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
