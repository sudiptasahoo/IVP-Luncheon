//
//  SSLandingViewController.swift
//  IVP Luncheon
//
//  Created by Sudipta Sahoo on 21/05/17.
//  Copyright © 2017 Sudipta Sahoo. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift


class SSLandingViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
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
    
    func saveReview(){
        
        let review = Review()
        review.id = "123"
        review.venueId = "234"
        review.reviewText = "abc"
        
        let realm = try! Realm()

        try! realm.write {
            realm.add(review)
        }
        
        let reviews = realm.objects(Review.self)
        print(reviews[0].reviewText)

    }
    
    func getFoursquareVenues(){
        self.collectionView.layoutIfNeeded()
        self.saveReview()
        SSApiService().searchVenues(categoryId: Constants.FOURSQUARE.FOOD_CATEGORY_ID, lat: SSLocationUtility.getUserLatestLatitude(), long: SSLocationUtility.getUserLatestLongitude(), success: { (data) in
            
            if(self.venues.count==0){
                self.hideSplashScreen()
            }
            
            do {
                
                let response = try JSONSerialization.jsonObject(with:data
                    , options:
                    JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
                
                if (response != nil){
                    
                    let venueResponse = VenueResponse.init(dictionary: response)
                    self.venues = (venueResponse?.response?.venues)!
                    
                    DispatchQueue.main.async {
                        
                        self.collectionView.reloadData()
                        self.collectionView.layoutIfNeeded()
                        self.refresher.endRefreshing()
                    }
                }
               
                
            } catch let error {
                
                print("JSON Processing Failed \(error)")
                DispatchQueue.main.async {
                    self.refresher.endRefreshing()
                }
            }

            
        }, failure: { (error) in
            print("Network Error \(error)")
            //Scope for better error handling with Retry button, etc
            if(self.venues.count==0){
                self.hideSplashScreen()
            }
            
            DispatchQueue.main.async {
                self.refresher.endRefreshing()
            }

        })
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
        let cell : SSVenueListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SSVenueListCollectionViewCell",
                                                                                   for: indexPath) as! SSVenueListCollectionViewCell
        cell.backgroundColor = UIColor.white
        let venue = venues[indexPath.row]
        cell.titleLbl.text = venue.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width, height: 102)
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

