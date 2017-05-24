//
//  SSExtensions.swift
//  IVP Luncheon
//
//  Created by Sudipta Sahoo on 24/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

extension URLComponents {
    
    mutating func appendQueryItem(name: String, value: String) {
        var queryItems: [URLQueryItem] = self.queryItems!
        queryItems.append(NSURLQueryItem(name: name, value: value) as URLQueryItem)
        self.queryItems = queryItems as [URLQueryItem]
    }
    
    mutating func appendQueryItems(_ additionalQueryItems : [URLQueryItem]) {
        var queryItems: [URLQueryItem] = self.queryItems!
        queryItems.append(contentsOf: additionalQueryItems)
        self.queryItems = queryItems as [URLQueryItem]
    }
}
