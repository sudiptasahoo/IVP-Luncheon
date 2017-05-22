//
//  LaunchViewController.swift
//  RoposoTask
//
//  Created by Sudipta Sahoo on 16/01/17.
//  Copyright © 2017 Sudipta Sahoo. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var launchLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = M_PI
        rotationAnimation.duration = 1.0
        rotationAnimation.repeatCount = Float.infinity
        
        self.launchLogo.layer.add(rotationAnimation, forKey: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
