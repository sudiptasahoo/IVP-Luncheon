//
//  SSApiService.swift
//  IVP Luncheon
//
//  Created by Sudipta Sahoo on 22/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

class SSApiService: NSObject {
    
    //There is a scope of making it singleton. But why to make this singleton and give a burden to keep the instance in memory throughout the app lifecycle.
    //static let shared = SSApiService()
    
    var urlComponents = URLComponents()
    
    override init() {
        super.init()
        urlComponents.scheme = Constants.URL.FOURSQUARE_API.scheme;
        urlComponents.host = Constants.URL.FOURSQUARE_API.host;
        
        let clientIdQuery = URLQueryItem(name: "client_id", value: Constants.FOURSQUARE.CLIENT_ID)
        let clientSecretQuery = URLQueryItem(name: "client_secret", value: Constants.FOURSQUARE.CLIENT_SECRET)
        let vQuery = URLQueryItem(name: "v", value: Constants.API.v)
        urlComponents.appendQueryItems([clientIdQuery,clientSecretQuery,vQuery])
    }
    
    func exploreVenues(categoryId: String, lat: String, long: String, success: @escaping (_ data: Data) -> Void, failure:@escaping (_ error: Error)->Void){

        urlComponents.path = Constants.URL.FOURSQUARE_API.explore;
        
        let latLongQuery = URLQueryItem(name: "ll", value: lat+","+long)
        let categoryIdQuery = URLQueryItem(name: "categoryId", value: categoryId)
        
        //The class level urlComponents gets mutated. Will have to change the code if this class is made Singleton anytime
        urlComponents.appendQueryItems([latLongQuery,categoryIdQuery])
        
        let request = URLRequest(url: urlComponents.url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: Constants.API.TIMEOUT)
        
        SSNetworkHandshake().getJsonResponse(fromRequest: request, success: success, failure: failure)
    }
  
  func getVenueDetails(venueId: String, success: @escaping (_ data: Data) -> Void, failure:@escaping (_ error: Error)->Void){
    
    urlComponents.path = Constants.URL.FOURSQUARE_API.venueDetails + venueId;
    
    let request = URLRequest(url: urlComponents.url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: Constants.API.TIMEOUT)
    
    SSNetworkHandshake().getJsonResponse(fromRequest: request, success: success, failure: failure)
  }
}
