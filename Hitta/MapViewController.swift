//
//  MapViewController.swift
//  Hitta
//
//  Created by Gustaf Kugelberg on 13/02/16.
//  Copyright © 2016 Unfair. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    // MARK: Lifetime
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded")
    }
    
    // MARK: Overrides
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: User actions
    
    @IBAction func tappedClose() {
        dismissViewControllerAnimated(true) {
            
        }
    }
}