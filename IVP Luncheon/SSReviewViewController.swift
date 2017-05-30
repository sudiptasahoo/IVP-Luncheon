//
//  SSReviewViewController.swift
//  IVP Luncheon
//
//  Created by Sudipta on 28/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

protocol ReviewProtocol {
  func reviewAdded()
}

class SSReviewViewController: UIViewController {
  
  @IBOutlet weak var reviewTF: UITextField!
  @IBOutlet weak var postBtn: UIButton!
  var venueId : String!
  var venueName : String!
  var delegate : ReviewProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    reviewTF.delegate = self
    self.title = venueName
    // Do any additional setup after loading the view.
  }
  @IBAction func postBtnAction(_ sender: UIButton) {
    
    SSTipPersistenceService().save(reviewTF.text!, forVenueId: venueId)
    delegate?.reviewAdded()
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
