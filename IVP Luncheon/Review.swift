//
//  Review.swift
//
//
//  Created by Sudipta Sahoo on 23/05/17.
//
//

import Foundation
import RealmSwift

class Review: Object {
  
  dynamic var id = ""
  dynamic var venueId = ""
  var tips = List<LocalTip>()
  dynamic var thumbsUp = false
  dynamic var thumbsDown = false
  dynamic var createdOn = NSDate()
  
  
}
