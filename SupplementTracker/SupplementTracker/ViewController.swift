//
//  ViewController.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/5/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var supplements = [NSManagedObject]()
    
    
    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in
            
            let textField = alert.textFields!.first
            self.saveName(textField!.text!,day: "MWF")
            self.tableView.reloadData()
        })
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {(action: UIAlertAction) -> Void in}
        alert.addTextFieldWithConfigurationHandler{(textField: UITextField) -> Void in}
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
    
        presentViewController(alert, animated:true, completion:nil)
    }
    func saveName(name: String, day: String){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Supplement",inManagedObjectContext:managedContext)
        
        let supplement = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        supplement.setValue(name,forKey:"name")
        supplement.setValue(day,forKey:"day")
        
        do {
            try managedContext.save()
            supplements.append(supplement)
        } catch let error as NSError{
           print("Coule not save \(error), \(error.userInfo)")
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Supplement")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            supplements = results as! [NSManagedObject]
        } catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supplements.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let supplement = supplements[indexPath.row]
        
        let n = supplement.valueForKey("name") as! String
        let d = supplement.valueForKey("day") as! String
        let labelText:String = ("\(n) , \(d)")
        cell!.textLabel!.text = labelText
        
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

