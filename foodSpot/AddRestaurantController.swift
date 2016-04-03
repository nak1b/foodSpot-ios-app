//
//  AddRestaurantController.swift
//  foodSpot
//
//  Created by Nakib on 4/3/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class AddRestaurantController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath
        indexPath: NSIndexPath) {
        if indexPath.row == 0 {
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion:
        nil)
        }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("asdasdas");
    }
}
