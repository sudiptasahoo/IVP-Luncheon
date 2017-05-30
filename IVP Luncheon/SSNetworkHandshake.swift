//
//  SSNetworkHandshake.swift
//  IVP Luncheon
//
//  Created by Sudipta Sahoo on 22/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit
import Foundation


//This is the Network Interceptor and single point of entry/exit for any network call throughout the app
class SSNetworkHandshake: NSObject {

    func getJsonResponse(fromRequest request: URLRequest, success: @escaping (_ data: Data) -> Void, failure:@escaping (_ error: Error)->Void){
        
        print(String(describing: request.url))
        
        let session = URLSession.shared
        
        if(currentReachabilityState != .notReachable){
            //Network connectivity present
            
            //This cud have been achieved through AlamofireNetworkActivityIndicator
            //But below is my custom implimentation to handle iOS Network Indicator effectively
            SSCommonUtilities.addTaskToNetworkQueue()
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                SSCommonUtilities.removeTaskFromNetworkQueue()
                if(error == nil) {
                    success(data!);
                } else {
                    failure(error!);
                }
            })
            task.resume()
        } else {
            //Network connectivity not present
            
            let userInfo: [String : AnyHashable] =
                [
                    NSLocalizedDescriptionKey :  NSLocalizedString("Internet Not Available", value: "", comment: "Please check your network."),
                    ]
            let err = NSError(domain: "com.sudipta.apiResponseErrorDomain", code: 400, userInfo: userInfo)
            
            failure(err)
        }
    }
    
}
