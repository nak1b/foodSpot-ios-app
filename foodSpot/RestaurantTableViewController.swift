//
//  RestaurantTableViewController.swift
//  foodSpot
//
//  Created by Nakib on 3/10/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var fetchResultController:NSFetchedResultsController!
    var restaurants:[Restaurant] = []
    
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
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.typeLabel.text = restaurants[indexPath.row].type
        cell.locationLabel.text = restaurants[indexPath.row].location
        
        cell.thumbImageView.image = UIImage(data: restaurants[indexPath.row].image!)
        if let isVisited = restaurants[indexPath.row].isVisited?.boolValue {
            cell.accessoryType = isVisited ? .Checkmark : .None
        }

        
        return cell
    }

//MARK: ActionSheet
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//            //Create option Menu
//            let optionMenu = UIAlertController(title: nil, message: "What do you want to do today", preferredStyle: .ActionSheet)
//            
//            //Add Cancel action to menu
//            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//            optionMenu.addAction(cancelAction)
//            
//            //Add call action
//            let callActionHandler = {(action: UIAlertAction!) -> Void in
//                let alertMessage = UIAlertController(title: "Service Unavailable", message:
//                "Sorry, the call feature is not available yet. Please retry later.",
//                preferredStyle: .Alert)
//                alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler:
//                nil))
//                self.presentViewController(alertMessage, animated: true, completion: nil)
//            }
//            
//            let callAction = UIAlertAction(title: "Call 401-000-5555", style: .Default, handler: callActionHandler)
//            optionMenu.addAction(callAction)
//            
//            
//            //Add I'have been here action
//            let isVisitedTitle = (restaurantIsVisited[indexPath.row]) ? "I've not been here" : "I've been here"
//            let isVisitedAction = UIAlertAction(title: isVisitedTitle, style: .Default,
//                    handler: {
//                       (action:UIAlertAction!) -> Void in
//                        let cell = tableView.cellForRowAtIndexPath(indexPath)
//                        self.restaurantIsVisited[indexPath.row] = !self.restaurantIsVisited[indexPath.row]
//                        cell?.accessoryType = (self.restaurantIsVisited[indexPath.row]) ? .Checkmark : .None
//                    })
//            optionMenu.addAction(isVisitedAction)
//            
//            //Present option menu
//            self.presentViewController(optionMenu, animated: true, completion: nil)
//            
//            tableView.deselectRowAtIndexPath(indexPath, animated: true)
//            
//    }
    
    
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
              self.restaurants.removeAtIndex(indexPath.row)
              tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showRestaurantDetail"){
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destinationViewController as! RestaurantDetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
    }
    
    
    //Back to homescreen when cancel press on Add Restaurat Screen
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
    }

}
