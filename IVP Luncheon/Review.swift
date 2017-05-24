//
//  Review+CoreDataClass.swift
//  
//
//  Created by Sudipta Sahoo on 23/05/17.
//
//

import Foundation
import CoreData

class Review: NSManagedObject {

    @NSManaged public var id: String?
    @NSManaged public var venueId: String?
    @NSManaged public var reviewText: String?

}
