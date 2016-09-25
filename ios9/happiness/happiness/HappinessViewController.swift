//
//  HappinessViewController.swift
//  happiness
//
//  Created by Alex Skryl on 6/23/15.
//  Copyright (c) 2015 Alex Skryl. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController {

    var happiness: Int = 50 { // 0 = very sad, 100 = happy
        didSet {
            happiness = min(max(happiness, 0), 100)
            updateUI()
        }
    }
    
    func updateUI()
    {
      
    }
}
