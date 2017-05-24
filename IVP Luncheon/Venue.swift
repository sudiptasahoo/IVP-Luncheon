//
//  Venue+CoreDataClass.swift
//  
//
//  Created by Sudipta Sahoo on 23/05/17.
//
//

import Foundation
import CoreData

class Venue: NSManagedObject {

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var reviews: Review?
}
