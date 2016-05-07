//
//  RestaurantTableViewController.swift
//  foodSpot
//
//  Created by Nakib on 3/10/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var fetchResultController:NSFetchedResultsController!
    var restaurants:[Restaurant] = []
    var searchController:UISearchController!
    var searchResults:[Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        //self sizing cells
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //CoreData :- Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext{
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do{
                try fetchResultController.performFetch()
                restaurants = fetchResultController.fetchedObjects as! [Restaurant]
                
            }catch{
                print(error)
            }
        }
        
        //Adding SearchController on header
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search restaurants..."
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //Not showing edit option on search restaurants
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active{
            return searchResults.count
        }else{
           return restaurants.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
        
        //Setting restaurant to all restaurant or serached restaurant
        let restaurant = (searchController.active) ? searchResults[indexPath.row] :
            restaurants[indexPath.row]
        
        cell.nameLabel.text = restaurant.name
        cell.typeLabel.text = restaurant.type
        cell.locationLabel.text = restaurant.location
        
        cell.thumbImageView.image = UIImage(data: restaurant.image!)
        if let isVisited = restaurant.isVisited?.boolValue {
            cell.accessoryType = isVisited ? .Checkmark : .None
        }

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active{
            return false
        }else{
            return true
        }
    }
    
    
    //COREDATA :- Updating Table on DataChange
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type{
        case .Insert:
            if let _newIndexPath = newIndexPath{
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
            
        case .Delete:
            if let _indexPath = indexPath{
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
            
        case .Update:
            if let _indexPath = indexPath{
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        //social sharing button
        let shareAction = UITableViewRowAction(style: .Normal, title: "Share") { (action, indexPath) -> Void in
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
            
            if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image!) {
                let activityController = UIActivityViewController(activityItems:
                    [defaultText, imageToShare], applicationActivities: nil)
                self.presentViewController(activityController, animated: true, completion: nil)
            }
            
            let activityController = UIActivityViewController(activityItems:
                [defaultText], applicationActivities: nil)
            self.presentViewController(activityController, animated: true,
                completion: nil)
        }
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0,
                    blue: 253.0/255.0, alpha: 1.0)
        
        //Delete Action
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) -> Void in
              // Delete the row from the data source
            
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext{
                let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
                managedObjectContext.deleteObject(restaurantToDelete)
                
                do{
                    try managedObjectContext.save()
                }catch{
                    print(error)
                }
            }
        }
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showRestaurantDetail"){
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destinationViewController as! RestaurantDetailViewController
                    destinationController.restaurant = (searchController.active) ?searchResults[indexPath.row] : restaurants[indexPath.row]
            }
        }
    }
    
    
    //Back to homescreen when cancel press on Add Restaurat Screen
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
    }
    
    //Search:- Filtering Content
    func filterContentForSearch(searchText:String){
        searchResults = restaurants.filter({ (restaurant:Restaurant) -> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText, options:
                NSStringCompareOptions.CaseInsensitiveSearch)
            
            return nameMatch != nil
        })
    }
    
    //Updating the data with serach results
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let serachText = searchController.searchBar.text{
            filterContentForSearch(serachText)
        tableView.reloadData()
        }
    }

}
