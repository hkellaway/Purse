//
//  ViewController.swift
//  PurseDemo
//
//  Created by Harlan Kellaway on 4/24/18.
//  Copyright © 2018 Harlan Kellaway. All rights reserved.
//

import Purse
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let purseDirectory: Purse.Directory = .documents
        print(purseDirectory.description)
    }
    
}

