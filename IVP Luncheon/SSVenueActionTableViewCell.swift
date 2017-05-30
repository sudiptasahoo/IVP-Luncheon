//
//  SSVenueActionTableViewCell.swift
//  IVP Luncheon
//
//  Created by Sudipta on 29/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

class SSVenueActionTableViewCell: UITableViewCell {

  @IBOutlet weak var bgView: UIView!
  @IBOutlet weak var ratingLbl: UILabel!
  @IBOutlet weak var saveBtn: UIButton!
  @IBOutlet weak var thumbsUpBtn: UIButton!
  @IBOutlet weak var thumbsDownBtn: UIButton!
  @IBOutlet weak var leaveTipBtn: UIButton!
  @IBOutlet weak var bannerImage: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  @IBAction func thumbsUpAction(_ sender: Any) {
  }
  
  @IBAction func saveBtnAction(_ sender: Any) {
  }
  
  
  
  @IBAction func thumbsDownAction(_ sender: Any) {
  }
  
  @IBAction func leaveTipAction(_ sender: Any) {
  }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
