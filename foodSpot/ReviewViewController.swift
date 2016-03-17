//
//  ReviewViewController.swift
//  foodSpot
//
//  Created by Nakib on 3/16/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet weak var backgroundImageViw: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .Dark)
        let blueEffectView = UIVisualEffectView(effect: blurEffect)
        blueEffectView.frame = view.bounds
        backgroundImageViw.addSubview(blueEffectView)
    }
}
