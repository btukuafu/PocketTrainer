//
//  WorkoutList+CoreDataProperties.swift
//  
//
//  Created by Bruce Tukuafu on 3/9/23.
//
//

import Foundation
import CoreData


extension WorkoutList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutList> {
        return NSFetchRequest<WorkoutList>(entityName: "WorkoutList")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?

}
