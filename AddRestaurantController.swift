//
//  AddRestaurantController.swift
//  foodSpot
//
//  Created by Nakib on 4/3/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class AddRestaurantController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if indexPath.row == 0{
            let sourceSelection = UIAlertController(title: "Select image source", message: nil, preferredStyle: .ActionSheet)
            
            //Selecting Image from library
            let photoLibraryAction = UIAlertAction(title: "Choose from album", style: .Default, handler: {
                   void in
                   if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
                      let imageController = UIImagePickerController()
                      imageController.delegate = self
                      imageController.allowsEditing = false
                      imageController.sourceType = .PhotoLibrary
                    
                      //present image picker
                      self.presentViewController(imageController, animated: true, completion: nil)
                   }
                }
            )
            sourceSelection.addAction(photoLibraryAction)
            
            //Taking photo through camera
            let cameraAction = UIAlertAction(title: "Take a picture", style: .Default, handler:
                {
                    void in
                    if UIImagePickerController.isSourceTypeAvailable(.Camera){
                        let imageController = UIImagePickerController()
                        imageController.delegate = self
                        imageController.allowsEditing = false
                        imageController.sourceType = .Camera
                        
                        //present image picker
                        self.presentViewController(imageController, animated: true, completion: nil)
                    }
                }
            )
            sourceSelection.addAction(cameraAction)
            
            
            //Cancel Action
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            sourceSelection.addAction(cancelAction)
            
            
            //preset Selection Sheet
            self.presentViewController(sourceSelection, animated: true, completion: nil)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        dismissViewControllerAnimated(true, completion: nil)
    }
}
