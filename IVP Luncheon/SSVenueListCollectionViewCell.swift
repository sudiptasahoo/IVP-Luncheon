//
//  SSVenueListCollectionViewCell.swift
//  IVP Luncheon
//
//  Created by Sudipta Sahoo on 22/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

class SSVenueListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var checkinsLbl: UILabel!
    @IBOutlet weak var categoriesLbl: UILabel!
    @IBOutlet weak var beenHereLbl: UILabel!
    @IBOutlet weak var tipsLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
