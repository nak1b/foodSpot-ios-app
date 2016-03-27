//
//  RestaurantDetailViewController.swift
//  foodSpot
//
//  Created by Nakib on 3/12/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var restaurant:Restaurant!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    @IBOutlet var ratingButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = restaurant.name
        
        restaurantImageView.image = UIImage(named: restaurant.image)
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.2)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.8)
        
        //dynamic cell sizing
        tableView.estimatedRowHeight = 36
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Set the rating of the restaurant
        if restaurant.rating != "" {
            ratingButton.setImage(UIImage(named: restaurant.rating), forState: UIControlState.Normal)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RestaurantDetailTableViewCell
        
        switch indexPath.row{
          case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
          case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
          case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
          case 3:
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = restaurant.phoneNumber
          case 4:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I've been here": "No"
          default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        cell.backgroundColor = UIColor.clearColor()
        return cell;
        
    }
    
    //Rating Modal Closing
    @IBAction func close(segue:UIStoryboardSegue) {
        if let reviewController = segue.sourceViewController as? ReviewViewController{
            if let rating = reviewController.rating{
                restaurant.rating = rating
                ratingButton.setImage(UIImage(named: rating), forState: .Normal)
            }
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap"{
            let destinationController = segue.destinationViewController as! MapViewController
            destinationController.restaurant = restaurant
        }
    }
    
    
}
