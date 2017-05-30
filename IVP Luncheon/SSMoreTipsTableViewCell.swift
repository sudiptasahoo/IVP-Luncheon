//
//  SSMoreTipsTableViewCell.swift
//  IVP Luncheon
//
//  Created by Sudipta on 29/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

class SSMoreTipsTableViewCell: UITableViewCell {

  @IBOutlet weak var moreTipsBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  @IBAction func moreTipsBtnAction(_ sender: Any) {
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
