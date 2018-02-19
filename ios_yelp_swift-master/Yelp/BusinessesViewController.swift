//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  var businesses: [Business]!
  var searchBar = UISearchBar()
  var queryString: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //let searchBar = UISearchBar
    navigationItem.titleView = searchBar
    searchBar.sizeToFit()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 120
    
    callYelpAPI("Vegan")
    
    /* Example of Yelp search with more search options specified
     Business.searchWithTerm("Restaurants", sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
     self.businesses = businesses
     
     for business in businesses {
     print(business.name!)
     print(business.address!)
     }
     }
     */
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if businesses != nil {
      return businesses.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
    
    cell.business = businesses[indexPath.row]
    
    return cell
  }
  
  
  func callYelpAPI(_ query: String) {
    Business.searchWithTerm(term: query, completion: { (businesses: [Business]?, error: Error?) -> Void in
      self.businesses = businesses
      self.tableView.reloadData()
      if let businesses = businesses {
        for business in businesses {
          print(business.name!)
          print(business.address!)
        }
      }
      
    }
    )
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
    searchBar.text = ""
    searchBar.resignFirstResponder()
    self.tableView.reloadData()
  }

  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    callYelpAPI(searchBar.text!)
    self.tableView.reloadData()
    searchBar.resignFirstResponder()
  }
}


