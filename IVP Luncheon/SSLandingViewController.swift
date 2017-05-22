//
//  SSLandingViewController.swift
//  IVP Luncheon
//
//  Created by Sudipta Sahoo on 21/05/17.
//  Copyright © 2017 Sudipta Sahoo. All rights reserved.
//

import UIKit
import Alamofire


class SSLandingViewController : UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    private var venues = [Venue]()
    private var refresher : UIRefreshControl!
    private var lastContentOffset: CGFloat = 0
    var splashVC : LaunchViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionView.backgroundColor = UIColor.black
        let nib = UINib(nibName: "SSVenueListCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SSVenueListCollectionViewCell")
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Pull To Refrsh
        self.collectionView!.alwaysBounceVertical = true
        refresher = UIRefreshControl(frame: CGRect(x: self.view.frame.width/2, y: -54, width: 20, height: 20))
        refresher.tintColor = UIColor.orange
        
        let refresherTitle = "Pull to refersh" // Scope for Last Updated <> ago using the flickrFeed.modifiedOn field
        let multipleAttributes : [String : Any] = [
            NSForegroundColorAttributeName: UIColor.yellow]
        self.refresher.attributedTitle = NSAttributedString(string: refresherTitle, attributes: multipleAttributes)
        
        refresher.addTarget(self, action: #selector(getFoursquareVenues), for: .valueChanged)
        collectionView!.addSubview(refresher)
        refresher.bounds = CGRect(x: 0, y: -54, width: 25, height: 25)
        
        self.navigationController?.navigationBar.backItem?.title = " "
        
        showSplashScreen()
        
        getFoursquareVenues();
        
    }

    func showSplashScreen(){
        
        self.splashVC =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Launch") as? LaunchViewController
        self.view.addSubview((splashVC?.view)!)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func hideSplashScreen(){
        
        DispatchQueue.main.async {
            
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.splashVC?.view.removeFromSuperview()
            }, completion: nil)
            
        }
    }
    
    func getFoursquareVenues(){
        
        
    }
    
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
    }
    
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            // user moving up
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        else if (self.lastContentOffset < scrollView.contentOffset.y) {
            // user moving down
            
        }
        
        // keep the last offset value safe
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

