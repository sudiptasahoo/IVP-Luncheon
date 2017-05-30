//
//  SSVenueUtilities.swift
//  IVP Luncheon
//
//  Created by Sudipta on 29/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

class SSVenueUtilities: NSObject {

  class func getDistanceString(_ fromMeters: Int) -> String{
    
    if(fromMeters < 1000){
      return "\(fromMeters) m"
    } else {
      return "\(fromMeters/1000).\(Int((fromMeters%1000)/10)) km"
    }
  }
  
}
