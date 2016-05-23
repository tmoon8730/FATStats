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

class EditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var tableView: UITableView!
    
    var displayObjectsArray = [NSManagedObject]() // Array to hold all the currently displayed data
    let DAO = CoreDataDAO()
    var chosenCellIndex: Int = 0
    
    // These variables are set in the Storyboard
    @IBInspectable var viewTitle: String?
    @IBInspectable var entityToSave: String!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.viewTitle
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
       // tableView.separatorStyle = .None
        tableView.rowHeight = 50.0
    }
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
        let managedContext = appDelegate.managedObjectContext
        
        // Load the list of objects for the entity
        displayObjectsArray = DAO.listAllData(managedContext, entityName: entityToSave)
        print("editviewcontroller \(displayObjectsArray.count)")
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayObjectsArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell!
        
        let displayObject = displayObjectsArray[indexPath.row]
        
        cell?.backgroundColor = colorForIndex(indexPath.row) // Sets the color and makes a gradient based on the number of rows
        cell?.selectionStyle = .None
        cell.supplementItem = displayObject // Sets the data to display
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        // When the user taps on a cell a segue happens to the AddViewController
        chosenCellIndex = indexPath.row
        self.performSegueWithIdentifier("editSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // get a reference to the second view controller
        let secondViewController = segue.destinationViewController as! AddViewController
        
        // set a variable in the second view controller with the data to pass
        
        let supplement = displayObjectsArray[chosenCellIndex]
        
        // Set the variables in the AddViewController so that the text fields and buttons will reflect the existing data
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



