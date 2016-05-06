//
//  Restaurant.swift
//  foodSpot
//
//  Created by Nakib on 3/12/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import Foundation
import CoreData

class Restaurant: NSManagedObject {
    @NSManaged var name:String
    @NSManaged var type:String
    @NSManaged var location:String
    @NSManaged var phoneNumber:String?
    @NSManaged var image:NSData?
    @NSManaged var isVisited: NSNumber?
    @NSManaged var rating:String?
    
}