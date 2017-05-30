//
//  SSCenteredButton.swift
//  IVP Luncheon
//
//  Created by Sudipta on 30/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

class SSCenteredButton: UIButton
{
  override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
    let rect = super.titleRect(forContentRect: contentRect)
    let imageRect = super.imageRect(forContentRect: contentRect)
    
    return CGRect(x: 0, y: imageRect.maxY + 10,
                  width: contentRect.width, height: rect.height)
  }
  
  override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
    let rect = super.imageRect(forContentRect: contentRect)
    let titleRect = self.titleRect(forContentRect: contentRect)
    
    return CGRect(x: contentRect.width/2.0 - rect.width/2.0,
                  y: (contentRect.height - titleRect.height)/2.0 - rect.height/2.0,
                  width: rect.width, height: rect.height)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    centerTitleLabel()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    centerTitleLabel()
  }
  
  private func centerTitleLabel() {
    self.titleLabel?.textAlignment = .center
  }
}
