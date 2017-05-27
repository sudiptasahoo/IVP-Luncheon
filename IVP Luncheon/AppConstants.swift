//
//  AppConstants.swift
//  RoposoTask
//
//  Created by Sudipta Sahoo on 15/01/17.
//  Copyright © 2017 Sudipta Sahoo. All rights reserved.
//

import UIKit

struct Constants {
    
    struct FOURSQUARE {
        static let CLIENT_ID = "OYRDUEDHAIEUUBXJOUDRZ2IDNUIPGAPVDTNQL2SSSX2SS23A"
        static let CLIENT_SECRET = "33IPKGMQPGTXU5WI2CBFCF5UTXC00V35GZLLL33UPBVEY1Q0"
        static let FOOD_CATEGORY_ID = "4d4b7105d754a06374d81259"
    }
    
    struct API{
        static let v = "20170517"
        static let TIMEOUT : TimeInterval = 30.0
    }
    
    struct URL {
        struct FOURSQUARE_API {
            static let scheme = "https"
            static let host = "api.foursquare.com"
            static let path = "/v2/venues/search"
        }
    }
    
    struct IVP {
        struct GURGAON_OFFICE{
            struct COORDINATE{
                static let lat = "28.536086"
                static let long = "77.398080"
            }
        }
    }
    
    struct TimeoutInterval {
        
    }
    
    
    struct DateFormat {
        
    }
    
    struct KEYS {
        struct COORDINATE {
            
            static let USER_COORDINATE = "USER_COORDINATE"
            
            static let USER_LATITUDE = "USER_LATITUDE"
            static let USER_LONGITUDE = "USER_LONGITUDE"
            static let USER_ACCURACY = "USER_ACCURACY"

        }
    }
}
