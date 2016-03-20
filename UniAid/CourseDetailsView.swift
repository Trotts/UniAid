//
//  CourseDetailsView.swift
//  UniAid
//
//  Created by Loai L. Felemban on 2016-03-18.
//  Copyright © 2016 igor epshtein. All rights reserved.
//

import Foundation
import UIKit


class CDView: UIViewController{
  
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