//
//  DayNotes+CoreDataProperties.swift
//  Nutriments
//
//  Created by Tyler Moon on 5/24/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension DayNotes {

    @NSManaged var day: String?
    @NSManaged var notes: String?
    @NSManaged var completed: Bool

}
