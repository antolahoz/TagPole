//
//  Activity+CoreDataProperties.swift
//  probablyareminder
//
//  Created by Antonio Lahoz on 03/03/23.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var descritpion: String?
    @NSManaged public var frequency: Int16
    @NSManaged public var icon: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var lastTimeDone: Date?
    @NSManaged public var name: String?
    @NSManaged public var selectedCategory: String?


}

extension Activity : Identifiable {

}
