//
//  SSCommonUtilities.swift
//  IVP Luncheon
//
//  Created by Sudipta Sahoo on 23/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

class SSCommonUtilities: NSObject {

    //MARK: Network Indicator Related Utilities
    static var networkQueue = 0;
    
    class func addTaskToNetworkQueue() -> Void{
        
        networkQueue += 1
        updateNetworkIndicatorStatus()
    }
    
    class func removeTaskFromNetworkQueue() -> Void{
        
        networkQueue -= 1
        updateNetworkIndicatorStatus()
    }
    
    class func updateNetworkIndicatorStatus(){
        
        if(networkQueue > 0){
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        } else if (networkQueue <= 0){
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

}
