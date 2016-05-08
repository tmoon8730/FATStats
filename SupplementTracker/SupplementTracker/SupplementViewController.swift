//
//  SupplementViewController.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/7/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SupplementViewController: UIViewController, UITableViewDataSource, TableViewCellDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var supplements = [NSManagedObject]()
    
    var txtField1: UITextField!
    var txtField2: UITextField!
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
        textField.placeholder = "Enter Supplement Name"
        txtField1 = textField
    }
    func addTextField2(textField: UITextField!){
        textField.placeholder = "Enter Days to be taken (Mon, Tue, Wed, Thur, Fri, Sat, Sun)"
        txtField2 = textField
    }
    func saveName(name: String, day: String){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Supplement",inManagedObjectContext:managedContext)
        
        let supplement = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        supplement.setValue(name,forKey:"name")
        supplement.setValue(day,forKey:"day")
        supplement.setValue(false,forKey:"completed")
        
        do {
            try managedContext.save()
            supplements.append(supplement)
        } catch let error as NSError{
            print("Coule not save \(error), \(error.userInfo)")
        }
        
        print("name = \(day) and getCurrentDay = \(getCurrentDay())")
        if(day != getCurrentDay())
        {
            let index = supplements.indexOf(supplement)
            supplements.removeAtIndex(index!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Supplements"
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .None
        tableView.rowHeight = 50.0
        tableView.backgroundColor = UIColor.blackColor()
        
    }
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Supplement")
        let predicate = NSPredicate(format:"day == %@",getCurrentDay())
        print(getCurrentDay())
        fetchRequest.predicate = predicate
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            supplements = results as! [NSManagedObject]
        } catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    func supplementItemDeleted(supplementItem: NSManagedObject){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let index = (supplements).indexOf(supplementItem)
        if index == NSNotFound { return }
        
        let objectRemoved:NSManagedObject! = supplements.removeAtIndex(index!)
        
        let predicate = NSPredicate(format: "name == %@", argumentArray: [objectRemoved.valueForKey("name")!])
        
        let fetchRequest = NSFetchRequest(entityName: "Supplement")
        fetchRequest.predicate = predicate
        
        do {
            let fetchedEntities = try managedContext.executeFetchRequest(fetchRequest)
            if let entitiyToDelete = fetchedEntities.first{
                managedContext.deleteObject(entitiyToDelete as! NSManagedObject)
            }
        } catch let error as NSError{
            print("Delete Error \(error), \(error.userInfo)")
        }
        
        
        do {
            try managedContext.save()
        }catch let error as NSError{
            print("Save Error \(error), \(error.userInfo)")
        }
        
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(forRow: index!, inSection: 0)
        tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        tableView.endUpdates()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supplements.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell!
        
        let supplement = supplements[indexPath.row]
        
        /* let n = supplement.valueForKey("name") as! String
         let d = supplement.valueForKey("day") as! String
         
         let labelText:String = ("\(n) , \(d)")
         cell!.textLabel!.text = labelText*/
        
        
        cell?.backgroundColor = colorForIndex(indexPath.row)
        cell?.selectionStyle = .None
        
        cell.delegate = self
        cell.supplementItem = supplement
        return cell!
    }
    func colorForIndex(index: Int) -> UIColor{
        let itemCount = supplements.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red:1.0, green:val, blue:0.0, alpha:0.9)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func awakeFromNib(){
        super.awakeFromNib()
        
        self.title = "Supplements"
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

