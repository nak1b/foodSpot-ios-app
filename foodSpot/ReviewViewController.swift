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
    @IBOutlet weak var ratingStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .Dark)
        let blueEffectView = UIVisualEffectView(effect: blurEffect)
        blueEffectView.frame = view.bounds
        backgroundImageViw.addSubview(blueEffectView)
        
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translate = CGAffineTransformMakeTranslation(0, 500)
        ratingStack.transform = CGAffineTransformConcat(scale, translate)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateKeyframesWithDuration(0.4, delay: 0.0, options: [], animations: {
              self.ratingStack.transform = CGAffineTransformIdentity

            }, completion: nil)
        
    
    }
}
