//
//  SSExtensions.swift
//  IVP Luncheon
//
//  Created by Sudipta Sahoo on 24/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit
import RealmSwift

enum SSFont {
  case helveticaMedium
  case helveticaMediumItalic
  case helveticaLight
  case helveticaRegular
}

extension URLComponents{
  
  mutating func appendQueryItem(name: String, value: String) {
    var queryItems: [URLQueryItem] = self.queryItems ?? [URLQueryItem]()
    queryItems.append(NSURLQueryItem(name: name, value: value) as URLQueryItem)
    self.queryItems = queryItems as [URLQueryItem]
  }
  
  mutating func appendQueryItems(_ additionalQueryItems : [URLQueryItem]) {
    var queryItems: [URLQueryItem] = self.queryItems ?? [URLQueryItem]()
    queryItems.append(contentsOf: additionalQueryItems)
    self.queryItems = queryItems as [URLQueryItem]
  }
}


extension UIFont{
  
  convenience init(font: SSFont, size: CGFloat){
    
    switch font {
    case .helveticaMedium:
      self.init(name: "HelveticaNeue-Medium", size: size)!
    case .helveticaLight:
      self.init(name: "HelveticaNeue-Light", size: size)!
    case .helveticaRegular:
      self.init(name: "HelveticaNeue", size: size)!
    case .helveticaMediumItalic:
      self.init(name: "HelveticaNeue-MediumItalic", size: size)!
    }
    
  }
}

extension UIColor {
  convenience init(hexString: String) {
    
    var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    let hex = cString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int = UInt32()
    Scanner(string: hex).scanHexInt32(&int)
    let a, r, g, b: UInt32
    switch hex.characters.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue:      CGFloat(b) / 255, alpha: CGFloat(a) / 255)
  }
}


extension UIViewController {
  
  func setTabBarVisible(visible: Bool, animated: Bool) {
    //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
    
    // bail if the current state matches the desired state
    if (isTabBarVisible == visible) { return }
    
    // get a frame calculation ready
    let frame = self.tabBarController?.tabBar.frame
    let height = frame?.size.height
    let offsetY = (visible ? -height! : height)
    
    // zero duration means no animation
    let duration: TimeInterval = (animated ? 0.3 : 0.0)
    
    //  animate the tabBar
    if frame != nil {
      UIView.animate(withDuration: duration) {
        self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
        return
      }
    }
  }
  
  var isTabBarVisible: Bool {
    return (self.tabBarController?.tabBar.frame.origin.y ?? 0) < self.view.frame.maxY
  }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
  
  func loadImageUsingCacheWithURL(url: String) {
    
    //Placehlder Image
    self.image = UIImage(named: "placeholder")
    
    // First check if there is an image in the cache
    if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
      
      self.image = cachedImage
      
      return
    }
      
    else {
      // Otherwise download image using the url
      SSCommonUtilities.addTaskToNetworkQueue()
      URLSession.shared.dataTask( with: URL(string: url)!, completionHandler: { (data, response, error) in
        
        SSCommonUtilities.removeTaskFromNetworkQueue()
        
        if error != nil {
          
          //Scope for retrying download
          
          print(error!)
        }
        else {
          DispatchQueue.main.async(execute: {
            
            // Cache to image so it doesn't need to be reloaded every time the user scrolls and table cells are re-used.
            if let downloadedImage = UIImage(data: data!) {
              
              imageCache.setObject(downloadedImage, forKey: url as String as AnyObject)
              
              UIView.transition(with: self,
                                duration: 0.3,
                                options: .transitionCrossDissolve,
                                animations: {
                                  self.image = downloadedImage
              },
                                completion: nil)
              
              
            }
          })
        }
      }).resume()
    }
  }
}


extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for i in 0 ..< count {
      if let result = self[i] as? T {
        array.append(result)
      }
    }
    
    return array
  }
}
