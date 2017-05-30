//
//  SSUIUtilities.swift
//  IVP Luncheon
//
//  Created by Sudipta on 29/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

class SSUIUtilities: NSObject {

  class func getSizeForLabel(_ withText:String, font:UIFont, width: CGFloat) -> CGRect{
    
    var currSize:CGRect!
    
    let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width: width, height:CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = withText
    label.sizeToFit()
    
    currSize = label.frame
    label.removeFromSuperview()
    
    return currSize
  }

}
