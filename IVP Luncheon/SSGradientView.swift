//
//  SSGradientView.swift
//  IVP Luncheon
//
//  Created by Sudipta on 29/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

@IBDesignable class SSGradientView: UIView {
  @IBInspectable var firstColor: UIColor = UIColor.red
  @IBInspectable var secondColor: UIColor = UIColor.green
  
  @IBInspectable var vertical: Bool = true
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    applyGradient()
  }
  
  func applyGradient() {
    let colors = [firstColor.cgColor, secondColor.cgColor]
    
    let layer = CAGradientLayer()
    layer.colors = colors
    layer.frame = self.bounds
    layer.startPoint = CGPoint(x: 0, y: 0)
    layer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    
    self.layer.addSublayer(layer)
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    #if TARGET_INTERFACE_BUILDER
      applyGradient()
    #endif
  }
}

@IBDesignable class ThreeColorsGradientView: UIView {
  @IBInspectable var firstColor: UIColor = UIColor.red
  @IBInspectable var secondColor: UIColor = UIColor.green
  @IBInspectable var thirdColor: UIColor = UIColor.blue
  
  @IBInspectable var vertical: Bool = true
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    applyGradient()
  }
  
  func applyGradient() {
    let colors = [firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor]
    
    let layer = CAGradientLayer()
    layer.colors = colors
    layer.frame = self.bounds
    layer.startPoint = CGPoint(x: 0, y: 0)
    layer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    
    self.layer.addSublayer(layer)
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    #if TARGET_INTERFACE_BUILDER
      applyGradient()
    #endif
  }
}

@IBDesignable class RadialGradientView: UIView {
  
  @IBInspectable var outsideColor: UIColor = UIColor.red
  @IBInspectable var insideColor: UIColor = UIColor.green
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    applyGradient()
  }
  
  func applyGradient() {
    let colors = [insideColor.cgColor, outsideColor.cgColor] as CFArray
    let endRadius = sqrt(pow(frame.width/2, 2) + pow(frame.height/2, 2))
    let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
    let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
    let context = UIGraphicsGetCurrentContext()
    
    context?.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    #if TARGET_INTERFACE_BUILDER
      applyGradient()
    #endif
  }
}
