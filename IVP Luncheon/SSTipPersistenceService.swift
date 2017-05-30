//
//  SSTipPersistenceService.swift
//  IVP Luncheon
//
//  Created by Sudipta on 30/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit
import RealmSwift

class SSTipPersistenceService: NSObject {
  
  var realm : Realm!
  
  //Singleton is not required
  
  override init() {
    super.init()
    realm = try! Realm()
    
  }
  
  func save(_ reviewText: String, forVenueId venueId: String){
    
    let result = realm.objects(Review.self).filter("venueId == '\(venueId)'")
    
    if(result.count > 0){
      try! realm.write {
        var tip = LocalTip()
        tip.text = reviewText
        result[0].tips.append(tip)
        
        realm.add(result)
      }
      
    } else{
      var review = Review()
      var tip = LocalTip()
      tip.text = reviewText
      review.id = UUID().uuidString
      review.tips.append(tip)
      review.venueId = venueId
      try! realm.write {
        realm.add(review)
      }
    }
    
  }
  
  func getAllReviewsFor(_ venueId: String) -> Results<Review>{
    
    let result =  realm.objects(Review.self).filter("venueId == '\(venueId)'")
    return result
    
  }
  
  func saveThumbsUpFor(venueId: String){
    
    let result = realm.objects(Review.self).filter("venueId == '\(venueId)'")
    
    if(result.count > 0){
      try! realm.write {
        result[0].thumbsUp = true
        result[0].thumbsDown = false
        realm.add(result)
      }
    } else{
      var review = Review()
      review.id = UUID().uuidString
      review.thumbsUp = true
      review.thumbsDown = false
      review.venueId = venueId
      try! realm.write {
        realm.add(review)
      }
    }
    
  }
  
  func saveThumbsDownFor(venueId: String){
    let result = realm.objects(Review.self).filter("venueId == '\(venueId)'")
    
    if(result.count > 0){
      try! realm.write {
        result[0].thumbsDown = true
        result[0].thumbsUp = false
        realm.add(result)
      }
    } else{
      var review = Review()
      review.id = UUID().uuidString
      review.thumbsDown = true
      review.thumbsUp = false
      review.venueId = venueId
      try! realm.write {
        realm.add(review)
      }
    }
  }
  
}
