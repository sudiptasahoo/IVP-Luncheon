//
//  SSVenueActionTableViewCell.swift
//  IVP Luncheon
//
//  Created by Sudipta on 29/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit
protocol VenueActionProtocol {
  func thumbsUpTapped(_ venueId: String)
  func thumbsDownTapped(_ venueId: String)
  func leaveTipTapped(_ venueId: String)
  
}



class SSVenueActionTableViewCell: UITableViewCell {
  
  @IBOutlet weak var bgView: UIView!
  @IBOutlet weak var ratingLbl: UILabel!
  @IBOutlet weak var saveBtn: UIButton!
  @IBOutlet weak var thumbsUpBtn: UIButton!
  @IBOutlet weak var thumbsDownBtn: UIButton!
  @IBOutlet weak var leaveTipBtn: UIButton!
  @IBOutlet weak var bannerImage: UIImageView!
  
  var venueId: String?
  var delegate : VenueActionProtocol?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.bannerImage.clipsToBounds = true
    self.bgView.isUserInteractionEnabled = false
  }
  
  @IBAction func thumbsUpAction(_ sender: Any) {
    self.thumbsUpBtn.setImage(UIImage(named:"thumbsUp_selected"), for: UIControlState.normal)
    self.thumbsDownBtn.setImage(UIImage(named:"thumbsDown"), for: UIControlState.normal)
    
    delegate?.thumbsUpTapped(venueId!)
  }
  
  @IBAction func saveBtnAction(_ sender: Any) {
  }
  
  
  
  @IBAction func thumbsDownAction(_ sender: Any) {
    self.thumbsUpBtn.setImage(UIImage(named:"thumbsUp"), for: UIControlState.normal)
    self.thumbsDownBtn.setImage(UIImage(named:"thumbsDown_selected"), for: UIControlState.normal)
    
    delegate?.thumbsDownTapped(venueId!)
  }
  
  @IBAction func leaveTipAction(_ sender: Any) {
    delegate?.leaveTipTapped(venueId!)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
