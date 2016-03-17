//
//  Restaurant.swift
//  foodSpot
//
//  Created by Nakib on 3/12/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import Foundation

class Restaurant{
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var phoneNumber = ""
    var isVisited = false
    
    init(name:String, type:String, location:String, phoneNumber:String, image:String, isVisited:Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
        self.phoneNumber = phoneNumber
    }
}