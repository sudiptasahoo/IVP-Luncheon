//
//  SSVenueDetailsViewController.swift
//  IVP Luncheon
//
//  Created by Sudipta on 29/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit
import RealmSwift

class SSVenueDetailsViewController: UIViewController {
  
  @IBOutlet weak var loader: UIActivityIndicatorView!
  @IBOutlet weak var bannerImageView: UIImageView!
  @IBOutlet weak var tableview: UITableView!
  var venueId : String!
  var venue : Venue?
  var imageView : UIImageView!
  var reviews : Array<Review>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bannerImageView.frame = CGRect(x: bannerImageView.frame.origin.x, y: bannerImageView.frame.origin.y, width: bannerImageView.frame.size.width, height: UIScreen.main.bounds.height/3)
    tableview.backgroundColor = .clear
    self.refreshTips()
    
    registerNibs()
    
    loadVenueDetails()
    
  }
  
  func registerNibs(){
    
    let venueNib = UINib(nibName: "SSVenueActionTableViewCell", bundle: nil)
    tableview.register(venueNib, forCellReuseIdentifier: "SSVenueActionTableViewCell")
    
    let locationNib = UINib(nibName: "SSVenueLocationTableViewCell", bundle: nil)
    tableview.register(locationNib, forCellReuseIdentifier: "SSVenueLocationTableViewCell")
    
    let tipBtnNib = UINib(nibName: "SSLeaveTipTableViewCell", bundle: nil)
    tableview.register(tipBtnNib, forCellReuseIdentifier: "SSLeaveTipTableViewCell")
    
    let tipNib = UINib(nibName: "SSTipsListTableViewCell", bundle: nil)
    tableview.register(tipNib, forCellReuseIdentifier: "SSTipsListTableViewCell")
    
    let moreTipNib = UINib(nibName: "SSMoreTipsTableViewCell", bundle: nil)
    tableview.register(moreTipNib, forCellReuseIdentifier: "SSMoreTipsTableViewCell")
    
    let suggestionNib = UINib(nibName: "SSVenueNearbySuggestionTableViewCell", bundle: nil)
    tableview.register(suggestionNib, forCellReuseIdentifier: "SSVenueNearbySuggestionTableViewCell")
    
  }
  
  
  func loadVenueDetails(){
    
    self.tableview.isHidden = true
    self.loader.startAnimating()
    
    SSApiService().getVenueDetails(venueId: venueId, success: { [weak self] (data) in
      
      self?.loader.stopAnimating()
      self?.tableview.isHidden = false
      do {
        
        let response = try JSONSerialization.jsonObject(with:data
          , options:
          JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
        
        if (response != nil){
          
          let responseJson = response.object(forKey: "response") as! NSDictionary
          if responseJson != nil{
            let venueJson = responseJson.object(forKey: "venue") as! NSDictionary
            if venueJson != nil{
              self?.venue = Venue.init(dictionary: venueJson)
            }
          }
        }
        
        DispatchQueue.main.async {
          
          self?.tableview.reloadData()
          self?.tableview.layoutIfNeeded()
          self?.title = self?.venue?.name
        }
        
        
      } catch let error {
        
        print("JSON Processing Failed \(error)")
        DispatchQueue.main.async {
          self?.loader.stopAnimating()
          self?.tableview.isHidden = false
          //Show up error popups
          
        }
      }
      
      
      }, failure: { (error) in
        print("Network Error \(error)")
        //Scope for better error handling with Retry button, etc
        DispatchQueue.main.async {
          self.loader.stopAnimating()
          self.tableview.isHidden = false
          //Show up error popups
        }
        
    })
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func refreshTips(){
    
    self.reviews = SSTipPersistenceService().getAllReviewsFor(venueId).toArray(ofType: Review.self)
  }
}


extension SSVenueDetailsViewController: UITableViewDataSource{
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    
    if let venueName = venue?.name{
      return 6
    } else{
      return 0
    }
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if let venueName = venue?.name{
      
      switch section {
      case 0:
        return 1
      case 1:
        return 1
      case 2:
        return 1
      case 3:
        
        if reviews.count > 0{
          return reviews[0].tips.count
        }
        return 1
      case 4:
        return 1
      default:
        return 0
      }
      
    } else{
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.section {
    case 0:
      
      let cell : SSVenueActionTableViewCell = tableview.dequeueReusableCell(withIdentifier: "SSVenueActionTableViewCell", for: indexPath) as! SSVenueActionTableViewCell
      cell.imageView?.loadImageUsingCacheWithURL(url: (venue?.bestPhoto?.prefix)! + "300x500" + (venue?.bestPhoto?.suffix)!)
      //Scope of preview here
      cell.imageView?.isUserInteractionEnabled = false
      cell.ratingLbl.layer.zPosition = 1
      cell.ratingLbl.text = String(describing: (venue?.rating)!)
      cell.ratingLbl.backgroundColor = UIColor(hexString: (venue?.ratingColor)!)
      cell.delegate = self
      cell.venueId = venueId
      cell.selectionStyle = .none
      if reviews.count != 0{
        if reviews[0].thumbsUp{
          cell.thumbsUpBtn.setImage(UIImage(named:"thumbsUp_selected"), for: UIControlState.normal)
        } else{
          cell.thumbsUpBtn.setImage(UIImage(named:"thumbsUp"), for: UIControlState.normal)

        }
        
        if reviews[0].thumbsDown{
          cell.thumbsDownBtn.setImage(UIImage(named:"thumbsDown_selected"), for: UIControlState.normal)

        } else{
          cell.thumbsDownBtn.setImage(UIImage(named:"thumbsDown"), for: UIControlState.normal)

        }
      }
      
      return cell
      
    case 1:
      
      let cell : SSVenueLocationTableViewCell = tableview.dequeueReusableCell(withIdentifier: "SSVenueLocationTableViewCell", for: indexPath) as! SSVenueLocationTableViewCell
      
      cell.locationLbl.text = ""
      if let location = venue?.location{
        if location.address != nil{
          cell.locationLbl.text = venue?.location?.address!
        }
      }
      cell.locationLbl.layer.zPosition = 1
      cell.locationLbl.sizeToFit()
      return cell
      
    case 2:
      
      let cell : SSLeaveTipTableViewCell = tableview.dequeueReusableCell(withIdentifier: "SSLeaveTipTableViewCell", for: indexPath) as! SSLeaveTipTableViewCell
      cell.delegate = self
      return cell
      
    case 3:
      
      //Actually SSTipsListTableViewCell should be used
      let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "tipCell")
      
      if reviews.count == 0{
        cell.textLabel?.text = "Yet to add tip"
      } else{
        
        let tip = self.reviews[0].tips[indexPath.row]
        cell.textLabel?.text = tip.text
        return cell
        
      }
    case 4:
      
      let cell : SSVenueNearbySuggestionTableViewCell = tableview.dequeueReusableCell(withIdentifier: "SSVenueNearbySuggestionTableViewCell", for: indexPath) as! SSVenueNearbySuggestionTableViewCell
      return cell
      
    default:
      return UITableViewCell()
    }
    
    return UITableViewCell()
  }
  
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    
    switch section {
    case 0:
      return ""
    case 1:
      return "Where is it located"
    case 2:
      return " "
    case 3:
      return "Tips by you"
    case 4:
      return "Search near \(String(describing: (venue?.name)!))"
    default:
      return ""
    }
  }
}


extension SSVenueDetailsViewController : UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    switch indexPath.section {
    case 0:
      return 246
    case 1:
      
      if let location = venue?.location{
        if location.address != nil{
          return SSUIUtilities.getSizeForLabel(location.address!, font: UIFont(font: .helveticaRegular, size: 15)
            , width: tableView.frame.width - 60).height + 20
        }
      }
      return 50
     
    case 2:
      return 108
    case 3:
      if reviews.count != 0 {
        return SSUIUtilities.getSizeForLabel(self.reviews[0].tips[indexPath.row].text , font: UIFont(font: .helveticaRegular, size: 14)
          , width: tableView.frame.width - 40).height + 20
      } else{
        //For no tip cell
        return 50
      }
    case 4:
      return 60
    default:
      return 0
    }
    
    return 0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
  func getVenueDetails() -> String{
    
    var vDetails : String = ""
    for part in (venue?.location?.formattedAddress)!{
      vDetails += "\n" + part
    }
    if let hours = venue?.hours?.status{
      vDetails += "\n" + hours
    }
    if let contact = venue?.contact?.formattedPhone{
      vDetails += "\n" + contact
    }
    
    return vDetails
  }
}


extension SSVenueDetailsViewController : SSLeaveTipDelegate{
  
  func writeATipTapped() {
    //tapped
    
    let vc = SSCommonUtilities.instantiateViewController("SSReviewViewController") as! SSReviewViewController
    vc.venueId = venueId
    vc.venueName = venue?.name
    vc.delegate = self

    self.navigationController?.pushViewController(vc, animated: true)
    
  }
}


extension SSVenueDetailsViewController: VenueActionProtocol{
  
  func thumbsUpTapped(_ venueId: String) {
    SSTipPersistenceService().saveThumbsUpFor(venueId: venueId)
    //in completion block
    //self.tableview.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableViewRowAnimation.automatic)
    //Lots of scope to update UI
    
  }
  
  func thumbsDownTapped(_ venueId: String) {
    SSTipPersistenceService().saveThumbsDownFor(venueId: venueId)
    //in completion block
    //self.tableview.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableViewRowAnimation.automatic)
  }
  
  func leaveTipTapped(_ venueId: String) {
    
    let vc = SSCommonUtilities.instantiateViewController("SSReviewViewController") as! SSReviewViewController
    vc.venueId = venueId
    vc.venueName = venue?.name
    vc.delegate = self
    self.navigationController?.pushViewController(vc, animated: true)
    
    //Scope to refresh this screen when user returns from Post Review screen.
    
  }
}

extension SSVenueDetailsViewController: ReviewProtocol{
  
  func reviewAdded() {
    
    self.navigationController?.popViewController(animated: true)
    
    refreshTips()
    self.tableview.reloadSections(NSIndexSet(index: 3) as IndexSet, with: UITableViewRowAnimation.automatic)
    
    let alertController = UIAlertController(title: "Success", message: "Your review is saved!", preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(defaultAction)
    
    self.present(alertController, animated: true, completion: nil)

  }
}
