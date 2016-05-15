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
    lazy var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
        self.title = todayTitle()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: Selector("refresh:"), forControlEvents: UIControlEvents.ValueChanged)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell!
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
        
        cell?.backgroundColor = UIColor.clearColor()
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
    
    func todayTitle() -> String{
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateFormat = "EEE, MMM dd"
        var convertedDate = dateFormatter.stringFromDate(currentDate)
        return convertedDate;
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
}
