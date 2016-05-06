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
   
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    
    var isVisited = true
    
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
        
        
        let leadingConstraint = NSLayoutConstraint(item: imageView, attribute: .Leading, relatedBy: .Equal, toItem: imageView.superview, attribute: .Leading, multiplier: 1, constant: 0)
        leadingConstraint.active = true
        
        let trailingConstraint = NSLayoutConstraint(item: imageView, attribute: .Trailing, relatedBy: .Equal, toItem: imageView.superview, attribute: .Trailing, multiplier: 1, constant: 0)
        trailingConstraint.active = true
        
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: imageView.superview, attribute: .Top, multiplier: 1, constant: 0)
        topConstraint.active = true
        
        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: imageView.superview, attribute: .Bottom, multiplier: 1, constant: 0)
        bottomConstraint.active = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Been Here Buttons Pressed
    @IBAction func beenHereBtns
        (sender: UIButton) {
    
        if sender == yesBtn{
           isVisited = true
            yesBtn.backgroundColor = UIColor(red: 0/255.0, green: 172/255.0, blue: 117/255.0, alpha: 1)
             noBtn.backgroundColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1)
        }else if sender == noBtn{
           isVisited = false
            noBtn.backgroundColor = UIColor(red: 0/255.0, green: 172/255.0, blue: 117/255.0, alpha: 1)
            yesBtn.backgroundColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1)

        }
    }
    //Save Button Pressed
    @IBAction func savePressed(sender: UIBarButtonItem) {
        let name = nameField.text
        let type = typeField.text
        let location = locationField.text
        
        //Check if all field enter or display error
        if name == "" || type == "" || location == ""{
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        print("Name: \(name)")
        print("Type: \(type)")
        print("Location: \(location)")
        print("Have you been here: \(isVisited)")
        
        // Dismiss the view controller
        dismissViewControllerAnimated(true, completion: nil)
        
    }
}
