//
//  CoreDataDAO.swift
//  SupplementTracker
//
//  Created by Tyler Moon on 5/8/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import CoreData
import UIKit

class CoreDataDAO {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    internal func saveData(managedContext: NSManagedObjectContext, entityName: String,name: String, day: String, completed: Bool) -> NSManagedObject {
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        managedObject.setValue(name,forKey:"name")
        managedObject.setValue(day,forKey:"day")
        managedObject.setValue(completed,forKey:"completed")
        do{
            try managedContext.save()
        }catch let e as NSError{
            print("Could not save \(e), \(e.userInfo)")
        }
        return managedObject
    }
    
    internal func deleteData(managedContext: NSManagedObjectContext, entitiyName: String, deleteItem: NSManagedObject){
        let predicate = NSPredicate(format: "name == %@", argumentArray: [deleteItem.valueForKey("name")!])
        let fetchRequest = NSFetchRequest(entityName: entitiyName)
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

    }
    
    
    
}
