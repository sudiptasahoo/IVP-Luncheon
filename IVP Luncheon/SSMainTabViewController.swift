//
//  SSMainTabViewController.swift
//  IVP Luncheon
//
//  Created by Sudipta on 29/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit

class SSMainTabViewController: UITabBarController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension SSMainTabViewController : UITabBarControllerDelegate{
  
  func tabBarController(_ tabBarController: UITabBarController,
                        didSelect viewController: UIViewController){
    
    print("tab changed")
  }
  
}
