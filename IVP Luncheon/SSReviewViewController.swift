//
//  SSReviewViewController.swift
//  IVP Luncheon
//
//  Created by Sudipta on 28/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

class SSReviewViewController: UIViewController {

    @IBOutlet weak var reviewTF: UITextField!
    @IBOutlet weak var postBtn: UIButton!
    var venueId : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTF.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func postBtnAction(_ sender: UIButton) {

        SSTipPersistenceService().save(reviewTF.text!, forVenueId: venueId)
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension SSReviewViewController: UITextFieldDelegate{
  
  //Many more things possible here
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    if (textField.text?.isEmpty)!{
      self.postBtn.isEnabled = false
    } else {
      self.postBtn.isEnabled = true
    }
  }
}
