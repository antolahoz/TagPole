//
//  Activity+CoreDataProperties.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 28/02/23.
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

}

extension Activity : Identifiable {

}
