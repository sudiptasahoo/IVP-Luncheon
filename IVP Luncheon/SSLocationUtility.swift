//
//  SSLocationUtility.swift
//  IVP Luncheon
//
//  Created by Sudipta Sahoo on 25/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

class SSLocationUtility: NSObject {

    class func saveUpdatedCoordinate(lat: String, long: String, accuracy: String){
        
        var dict = [String: Any]()
        dict[Constants.KEYS.COORDINATE.USER_LATITUDE] = lat
        dict[Constants.KEYS.COORDINATE.USER_LONGITUDE] = long
        dict[Constants.KEYS.COORDINATE.USER_ACCURACY] = accuracy

        UserDefaults.standard.set(dict, forKey: Constants.KEYS.COORDINATE.USER_COORDINATE)
        UserDefaults.standard.synchronize()
    }
    
    class func getUserLatestCoordinate() -> [String: Any]{
        
        return UserDefaults.standard.value(forKey: Constants.KEYS.COORDINATE.USER_COORDINATE) as! [String : Any]
    }
    
    class func getUserLatestLatitude() -> String{
        
        let coordinate = UserDefaults.standard.value(forKey: Constants.KEYS.COORDINATE.USER_COORDINATE) as! [String : Any]
        
        return coordinate[Constants.KEYS.COORDINATE.USER_LATITUDE] as! String
    }
    
    class func getUserLatestLongitude() -> String{
        
        let coordinate = UserDefaults.standard.value(forKey: Constants.KEYS.COORDINATE.USER_COORDINATE) as! [String : Any]
        
        return coordinate[Constants.KEYS.COORDINATE.USER_LONGITUDE] as! String
    }
    
    class func getUserLatestAccuracy() -> String{
        
        let coordinate = UserDefaults.standard.value(forKey: Constants.KEYS.COORDINATE.USER_COORDINATE) as! [String : Any]
        
        return coordinate[Constants.KEYS.COORDINATE.USER_ACCURACY] as! String
    }
    
}
