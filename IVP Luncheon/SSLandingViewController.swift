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
  
  
  @IBOutlet weak var loader: UIActivityIndicatorView!
  @IBOutlet weak var collectionView: UICollectionView!
  private var groups = [Group]()
  private var refresher : UIRefreshControl!
  private var lastContentOffset: CGFloat = 0
  var splashVC : LaunchViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 1
    layout.minimumLineSpacing = 1
    collectionView!.collectionViewLayout = layout
    
    
    self.collectionView.backgroundColor = UIColor(hexString: "939393")
    let nib = UINib(nibName: "SSVenueListCollectionViewCell", bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: "SSVenueListCollectionViewCell")
    self.automaticallyAdjustsScrollViewInsets = false
    
    //Pull To Refrsh
    self.collectionView!.alwaysBounceVertical = true
    refresher = UIRefreshControl(frame: CGRect(x: self.view.frame.width/2, y: 0, width: 20, height: 20))
    refresher.tintColor = UIColor.orange
    
    let refresherTitle = "Pull to refersh" // Scope for Last Updated <> ago using the flickrFeed.modifiedOn field
    let multipleAttributes : [String : Any] = [
      NSForegroundColorAttributeName: UIColor.white]
    self.refresher.attributedTitle = NSAttributedString(string: refresherTitle, attributes: multipleAttributes)
    
    refresher.addTarget(self, action: #selector(getFoursquareVenues), for: .valueChanged)
    collectionView!.addSubview(refresher)
    
    self.title = "Explore"

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
    self.collectionView.layoutIfNeeded()
    SSApiService().exploreVenues(categoryId: Constants.FOURSQUARE.FOOD_CATEGORY_ID, lat: SSLocationUtility.getUserLatestLatitude(), long: SSLocationUtility.getUserLatestLongitude(), success: { (data) in
      
      if(self.groups.count==0){
        self.hideSplashScreen()
      }
      
      do {
        
        let response = try JSONSerialization.jsonObject(with:data
          , options:
          JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
        
        if (response != nil){
          
          let venueResponse = ExploreVenueResponse.init(dictionary: response.object(forKey: "response") as! NSDictionary)
          self.groups = (venueResponse?.groups)!
          
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
      if(self.groups.count==0){
        self.hideSplashScreen()
      }
      
      DispatchQueue.main.async {
        self.refresher.endRefreshing()
      }
      
    })
  }
  
  
  // MARK: - UICollectionViewDataSource
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return self.groups.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return (self.groups[section].items?.count)!
  }
  
  
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell : SSVenueListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SSVenueListCollectionViewCell",
                                                                                  for: indexPath) as! SSVenueListCollectionViewCell
    cell.backgroundColor = UIColor.white
    let venue = self.groups[indexPath.section].items[indexPath.row].venue!
    
    if let venueName = venue.name{
      cell.titleLbl.text = venueName
    }
    if let category = venue.categories?[0].shortName{
      cell.categoriesLbl.isHidden = false
      cell.categoriesLbl.text = category
      cell.categoriesLbl.sizeToFit()
    } else{
      cell.categoriesLbl.isHidden = true
    }
    
    if (venue.price?.tier) != nil{
      cell.priceTierLbl.isHidden = false
      cell.priceTierLbl.attributedText = self.getPriceString(tier: (venue.price?.tier)!, currency: (venue.price?.currency)!)
      cell.priceTierLbl.sizeToFit()
    } else{
      cell.priceTierLbl.isHidden = true
    }
    
    if let venueCity = venue.location?.city{
      cell.cityLbl.text = venueCity
    }
    
    if let venueDistance = venue.location?.distance{
      cell.distanceLbl.text = SSVenueUtilities.getDistanceString(venueDistance)
    }
    
    if let venueRating = venue.rating, let venueRatingColor = venue.ratingColor{
      //More formatting required for padding on left and right
      let formattedRatingString = NSString(format: "%@%", String(venueRating))
      cell.ratingLbl.text = formattedRatingString as String
      cell.ratingLbl.sizeToFit()
      cell.ratingLbl.backgroundColor = UIColor(hexString: venueRatingColor)
      cell.ratingLbl.layer.cornerRadius = 4.0
      cell.ratingLbl.layer.masksToBounds = true
      cell.ratingLbl.isHidden = false
    } else{
      cell.ratingLbl.isHidden = true
    }
    
    
    cell.tipLbl.isHidden = true
    
    
    if let item = self.groups[indexPath.section].items{
      if let tips = item[indexPath.row].tips{
        if tips.count > 0 {
          if let tip = tips[0].tipText{
            cell.tipLbl.isHidden = false
            cell.tipLbl.text = tip
            cell.tipLbl.sizeToFit()
          }
        }
      }
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    var height: CGFloat = 88
    
    if let item = self.groups[indexPath.section].items{
      if let tips = item[indexPath.row].tips{
        if tips.count > 0 {
          if let tip = tips[0].tipText{
            height += SSUIUtilities.getSizeForLabel(tip, font: UIFont(font: .helveticaMedium, size: 14), width: self.collectionView.frame.width - 20).height
            height += 20
          }
        }
      }
    }

    return CGSize(width: collectionView.bounds.size.width, height: height)
  }
  
  // MARK: - UICollectionViewDelegate
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let venue = self.groups[indexPath.section].items[indexPath.row].venue!
    let vc = SSCommonUtilities.instantiateViewController("SSVenueDetailsViewController") as! SSVenueDetailsViewController
    vc.venueId = venue.id
    
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  // MARK: - UIScrollViewDelegate
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    if (self.lastContentOffset > scrollView.contentOffset.y) {
      // user moving up
      //Scope for hiding/unhiding ui elements
      //self.navigationController?.setNavigationBarHidden(false, animated: true)
      //self.setTabBarVisible(visible: true, animated: true)
      //self.view.setNeedsLayout()
    }
    else if (self.lastContentOffset < scrollView.contentOffset.y) {
      // user moving down
      //self.navigationController?.setNavigationBarHidden(true, animated: true)
      //self.setTabBarVisible(visible: false, animated: true)
      //self.view.setNeedsLayout()

    }
    
    // keep the last offset value safe
    self.lastContentOffset = scrollView.contentOffset.y
  }
  
  func getPriceString(tier: Int, currency: String) -> NSAttributedString{
    
    //Assuming it's black font by default
    let fullStr : NSString = String(repeating: currency, count: 5) as NSString
    let attributedStr = NSMutableAttributedString(string: fullStr as String, attributes: [NSForegroundColorAttributeName: UIColor.black])
    attributedStr.addAttribute(NSForegroundColorAttributeName, value: UIColor(hexString: "d3d3d3"), range: NSRange(location:tier, length:fullStr.length - tier))
    return attributedStr
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

