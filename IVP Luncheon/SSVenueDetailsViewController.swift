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
  var reviews : Results<Review>!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      bannerImageView.frame = CGRect(x: bannerImageView.frame.origin.x, y: bannerImageView.frame.origin.y, width: bannerImageView.frame.size.width, height: UIScreen.main.bounds.height/3)
      tableview.backgroundColor = .clear
      self.reviews = SSTipPersistenceService().getAllReviewsFor(venueId)
      
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
    
    SSApiService().getVenueDetails(venueId: venueId, success: { (data) in
      
      self.loader.stopAnimating()
      self.tableview.isHidden = false
      do {
        
        let response = try JSONSerialization.jsonObject(with:data
          , options:
          JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
        
        if (response != nil){
          
          let responseJson = response.object(forKey: "response") as! NSDictionary
          if responseJson != nil{
            let venueJson = responseJson.object(forKey: "venue") as! NSDictionary
            if venueJson != nil{
              self.venue = Venue.init(dictionary: venueJson)
            }
          }
          }
        
          DispatchQueue.main.async {
            
            self.tableview.reloadData()
            self.tableview.layoutIfNeeded()
          }
      
        
      } catch let error {
        
        print("JSON Processing Failed \(error)")
        DispatchQueue.main.async {
          self.loader.stopAnimating()
          self.tableview.isHidden = false
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
        if reviews != nil{
            return reviews[0].tips.count
        }
        return 0
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
      
      return cell

    case 1:

      let cell : SSVenueLocationTableViewCell = tableview.dequeueReusableCell(withIdentifier: "SSVenueLocationTableViewCell", for: indexPath) as! SSVenueLocationTableViewCell
      cell.locationLbl.text = getVenueDetails()
      return cell
      
    case 2:
      
      let cell : SSLeaveTipTableViewCell = tableview.dequeueReusableCell(withIdentifier: "SSLeaveTipTableViewCell", for: indexPath) as! SSLeaveTipTableViewCell
      cell.delegate = self
      return cell
      
    case 3:

      
      if indexPath.row <= 5{
        
        let tip = self.reviews[0].tips[indexPath.row]
        
        let cell : SSTipsListTableViewCell = tableview.dequeueReusableCell(withIdentifier: "SSTipsListTableViewCell", for: indexPath) as! SSTipsListTableViewCell
        //For demo purpose only
        cell.profileImage.loadImageUsingCacheWithURL(url: "http://www.american.edu/uploads/profiles/large/chris_palmer_profile_11.jpg")
        //To be used feature
        cell.tipImage.isHidden = true
        cell.tipText.text = tip.text
        return cell
        
      } else{
        
        let cell : SSMoreTipsTableViewCell = tableview.dequeueReusableCell(withIdentifier: "SSMoreTipsTableViewCell", for: indexPath) as! SSMoreTipsTableViewCell
        cell.moreTipsBtn.titleLabel?.text = "See all \(venue?.tips?.count) tips"
        return cell
        
      }
      
    case 4:

      let cell : SSVenueNearbySuggestionTableViewCell = tableview.dequeueReusableCell(withIdentifier: "SSVenueNearbySuggestionTableViewCell", for: indexPath) as! SSVenueNearbySuggestionTableViewCell
      return cell
      
    default:
      return UITableViewCell()
    }
    
    
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
      return "Search near \(venue?.name!)"
    default:
      return ""
    }
  }
}


extension SSVenueDetailsViewController : UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    switch indexPath.section {
    case 0:
      return 300
    case 1:
      return SSUIUtilities.getSizeForLabel(getVenueDetails(), font: UIFont(font: .helveticaRegular, size: 15)
        , width: tableView.frame.width - 60).height + 20
    case 2:
      return 108
    case 3:
      return SSUIUtilities.getSizeForLabel(self.reviews[0].tips[indexPath.row].text as! String, font: UIFont(font: .helveticaRegular, size: 14)
        , width: tableView.frame.width - 40).height + 20
    case 4:
      return 60
    default:
      return 0
    }
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
    
    self.navigationController?.pushViewController(vc, animated: true)
    
  }
}
