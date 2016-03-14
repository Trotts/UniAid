//
//  ViewController.swift
//  UniAid
//
//  Created by igor epshtein on 2016-02-10.
//  Copyright © 2016 igor epshtein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var open: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }

}

