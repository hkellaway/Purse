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
    
    var diskPersistence: DiskPersistence = Purse.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test1 = Test(id: 1, name: "Test 1")
        try? diskPersistence.persist(test1, to: .temporary, fileName: "test1.json")
        
        let retrievedTest1 = try? diskPersistence.retrieve(from: .temporary, fileName: "test1.json", as: Test.self)
        print(retrievedTest1 ?? "FAILED TO RETRIEVE :(")
    }
    
}

