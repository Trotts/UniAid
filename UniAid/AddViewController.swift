//
//  AddViewController.swift
//  UniAid
//
//  Created by Amr Zokari on 2016-03-25.
//  Copyright © 2016 igor epshtein. All rights reserved.
//

import Foundation
import UIKit

class addViewController: UIViewController {
    @IBOutlet var open: UIBarButtonItem!
     //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //code for swipe in -- needed
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
}
