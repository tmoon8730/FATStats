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
    
    // Save data to the specified entity, used for exercise and supplement data
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
    // Save data to the specified entity, used for day notes data
    internal func saveData(managedContext: NSManagedObjectContext, entityName: String, day: String, notes: String) -> NSManagedObject{
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedContext) // A variable containing information for a specific entity
        let managedObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) // A new NSManagedObject to insert into the CoreData entity
        managedObject.setValue(day,forKey:"day")
        managedObject.setValue(notes,forKey: "notes")
        do{
            try managedContext.save() // save the data to CoreData
        }catch let e as NSError{
            print("Could not save \(e), \(e.userInfo)")
        }
        return managedObject // return the object if the new object needs to be used to remove it from the array in the table

    }
    // Delete data from the specified entity
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
    // Returns all the data from a specified entity
    internal func listAllData(managedContext: NSManagedObjectContext, entityName: String) -> [NSManagedObject]{
        var returnArray = [NSManagedObject]()
        let fetchRequest = NSFetchRequest(entityName: entityName)
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            returnArray = results as! [NSManagedObject]
            print("\(returnArray.count)")
        }catch let e as NSError{
            print("Error getting list \(e), \(e.userInfo)")
        }
        return returnArray
    }
    // Returns all the data from a specified entity where the day field matches the current day
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
    
    internal func markCompleted(managedContext: NSManagedObjectContext, entityname: String, completedItem: NSManagedObject){
        let predicate = NSPredicate(format: "name == %@", argumentArray: [completedItem.valueForKey("name")!])
        
        let fetchRequest = NSFetchRequest(entityName: entityname)
        
        fetchRequest.predicate = predicate
        do{
            if let results = try managedContext.executeFetchRequest(fetchRequest) as? [Supplement]{
                results.first?.completed = !(results.first?.completed)!
                print("\(results)")
            }
            if let results = try managedContext.executeFetchRequest(fetchRequest) as? [Exercise]{
                results.first?.completed = !(results.first?.completed)!
                print("\(results)")
            }
            
        }catch let e as NSError{
            print("Error getting list \(e), \(e.userInfo)")
        }
        
        do {
            try managedContext.save()
        }catch let e as NSError{
            print("Error saving data \(e), \(e.userInfo)")
        }

    }
}
