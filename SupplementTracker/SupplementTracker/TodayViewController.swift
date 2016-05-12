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
        let supplementFetchRequest = NSFetchRequest(entityName: "Supplement")
        let supplementPredicate = NSPredicate(format:"day contains[c] %@",getCurrentDay())
        supplementFetchRequest.predicate = supplementPredicate
        do{
            let results = try managedContext.executeFetchRequest(supplementFetchRequest)
            supplementsArray = results as! [NSManagedObject]
        }catch let error as NSError{
            print("Error loading supplement data \(error)")
        }
        
        
        // Load exercise data
        let exerciseFetchRequest = NSFetchRequest(entityName: "Exercise")
        let exercisePredicate = NSPredicate(format:"day contains[c] %@",getCurrentDay())
        exerciseFetchRequest.predicate = exercisePredicate
        do{
            let results = try managedContext.executeFetchRequest(exerciseFetchRequest)
            exerciseArray = results as! [NSManagedObject]
        }catch let error as NSError{
            print("Error loading exercise data \(error)")
        }
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
    func getCurrentDay() -> String {
        var weekdayList: [String] = ["Sun","Mon","Tue","Wed","Thur","Fri","Sat"]
        
        switch NSDate().dayOfWeek()!
        {
        case 1: return weekdayList[0];
        case 2: return weekdayList[1];
        case 3: return weekdayList[2];
        case 4: return weekdayList[3];
        case 5: return weekdayList[4];
        case 6: return weekdayList[5];
        case 7: return weekdayList[6];
        default: return ""
        }
    }

}
