//
//  EditViewController.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/14/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class EditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var tableView: UITableView!
    var displayObjectsArray = [NSManagedObject]()
    let DAO = CoreDataDAO()
    var txtField1: UITextField!
    var txtField2: UITextField!
    var chosenCellIndex: Int = 0
    
    
    @IBInspectable var viewTitle: String?
    @IBInspectable var entityToSave: String!
    
    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "New Name", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler(addTextField1)
        alert.addTextFieldWithConfigurationHandler(addTextField2)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        //let textField = alert.textFields!.first
                                        self.saveName(self.txtField1.text!,day: self.txtField2.text!)
                                        self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {(action: UIAlertAction) -> Void in}
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated:true, completion:nil)
    }
    func addTextField1(textField: UITextField!){
        textField.placeholder = "Enter Exercise Name"
        txtField1 = textField
    }
    func addTextField2(textField: UITextField!){
        textField.placeholder = "Enter Days to be done (Mon, Tue, Wed, Thur, Fri, Sat, Sun)"
        txtField2 = textField
    }
    
    
    func saveName(name: String, day: String){
        let managedContext = appDelegate.managedObjectContext
        let exercise = DAO.saveData(managedContext, entityName: "Exercise", name: name, day: day, notes: " ", completed: false)
        displayObjectsArray.append(exercise)
        if(day != getCurrentDay())
        {
            let index = displayObjectsArray.indexOf(exercise)
            displayObjectsArray.removeAtIndex(index!)
        }
    }
    func supplementItemDeleted(supplementItem: NSManagedObject){
        let managedContext = appDelegate.managedObjectContext
        let index = (displayObjectsArray).indexOf(supplementItem)
        if index == NSNotFound { return }
        let objectRemoved:NSManagedObject! = displayObjectsArray.removeAtIndex(index!)
        DAO.deleteData(managedContext, entitiyName: "Exercise", deleteItem: objectRemoved)
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(forRow: index!, inSection: 0)
        tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        tableView.endUpdates()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.viewTitle
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .None
        tableView.rowHeight = 50.0
    }
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: entityToSave)
        let predicate = NSPredicate(format:"day contains[c] %@",getCurrentDay())
        print(getCurrentDay())
        fetchRequest.predicate = predicate
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            displayObjectsArray = results as! [NSManagedObject]
        } catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayObjectsArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell!
        
        let supplement = displayObjectsArray[indexPath.row]
        
        cell?.backgroundColor = colorForIndex(indexPath.row)
        cell?.selectionStyle = .None
        
        cell.delegate = self
        cell.supplementItem = supplement
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        chosenCellIndex = indexPath.row
        self.performSegueWithIdentifier("editSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // get a reference to the second view controller
        let secondViewController = segue.destinationViewController as! AddViewController
        
        // set a variable in the second view controller with the data to pass
        
        let supplement = displayObjectsArray[chosenCellIndex]
        
        secondViewController.addName = supplement.valueForKey("name") as! String
        secondViewController.addDay = supplement.valueForKey("day") as! String
        secondViewController.addNotes = supplement.valueForKey("notes") as! String
        secondViewController.editFlag = true
        
    }
    
    func colorForIndex(index: Int) -> UIColor{
        let itemCount = displayObjectsArray.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red:1.0, green:val, blue:0.0, alpha:0.9)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func awakeFromNib(){
        super.awakeFromNib()
        
        self.title = self.viewTitle
    }
    
}


extension NSDate{
    func dayOfWeek() ->Int? {
        if
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Weekday, fromDate:self){
            return comp.weekday
        } else{
            return nil
        }
    }
}
