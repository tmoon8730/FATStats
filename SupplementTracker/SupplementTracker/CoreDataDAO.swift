//
//  CoreDataDAO.swift
//  SupplementTracker
//  
//  CoreDataDAO is responsible for handling all data requests to the CoreData
//  database as well as deleting records
//
//  Created by Tyler Moon on 5/8/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import CoreData
import UIKit

class CoreDataDAO {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate // Used in accessing the CoreData database
    
    internal func saveData(managedContext: NSManagedObjectContext, entityName: String,name: String, day: String, notes: String, completed: Bool) -> NSManagedObject {
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedContext) // A variable containing information for a specific entity
        let managedObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) // A new NSManagedObject to insert into the CoreData entity
        managedObject.setValue(name,forKey:"name")
        managedObject.setValue(day,forKey:"day")
        managedObject.setValue(notes,forKey: "notes")
        managedObject.setValue(completed,forKey:"completed")
        do{
            try managedContext.save() // save the data to CoreData
        }catch let e as NSError{
            print("Could not save \(e), \(e.userInfo)")
        }
        return managedObject // return the object if the new object needs to be used to remove it from the array in the table
    }
    
    internal func deleteData(managedContext: NSManagedObjectContext, entitiyName: String, deleteItem: NSManagedObject){
        let predicate = NSPredicate(format: "name == %@", argumentArray: [deleteItem.valueForKey("name")!]) // Predicates are similar to SQL queries and specifiy which record to delete
        let fetchRequest = NSFetchRequest(entityName: entitiyName) // A wrapper for the predicate which does the request to the database
        fetchRequest.predicate = predicate
        
        do {
            let fetchedEntities = try managedContext.executeFetchRequest(fetchRequest)
            if let entitiyToDelete = fetchedEntities.first{ // Only need the first object as this method only deletes one record at a time
                managedContext.deleteObject(entitiyToDelete as! NSManagedObject)
            }
        } catch let error as NSError{
            print("Delete Error \(error), \(error.userInfo)")
        }
        
        
        do {
            try managedContext.save() // Save the new state without the deleted record
        }catch let error as NSError{
            print("Save Error \(error), \(error.userInfo)")
        }

    }
    internal func listAllData(managedContext: NSManagedObjectContext, entityName: String) -> [NSManagedObject]{
        var returnArray = [NSManagedObject]()
        let fetchRequest = NSFetchRequest(entityName: entityName)
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            returnArray = results as! [NSManagedObject]
        }catch let e as NSError{
            print("Error getting list \(e), \(e.userInfo)")
        }
        return returnArray
    }
    internal func listCurrentDayData(managedContext: NSManagedObjectContext, entityname: String) -> [NSManagedObject]{
        var returnArray = [NSManagedObject]()
        let fetchRequest = NSFetchRequest(entityName: entityname)
        let predicate = NSPredicate(format:"day contains[c] %@", getCurrentDay())
        fetchRequest.predicate = predicate
        do{
             let results = try managedContext.executeFetchRequest(fetchRequest)
             returnArray = results as! [NSManagedObject]
        }catch let e as NSError{
            print("Error getting list \(e), \(e.userInfo)")
        }
        return returnArray
    }
    
}
