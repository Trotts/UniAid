//
//  CourseDetailsView.swift
//  UniAid
//
//  Created by Loai L. Felemban on 2016-03-18.
//  Copyright © 2016 igor epshtein. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class CDView: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
  
  @IBOutlet var open: UIBarButtonItem!
  @IBOutlet weak var details: UITableView!
  
  var courseVar = [String]()
  var courseDetails = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    open.target = self.revealViewController()
    open.action = Selector("revealToggle:")
    
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
  
    details.delegate = self
    details.dataSource = self
    
    courseVar = ["Name", "Number", "Inst. Name", "Inst. Email", "Schedule", "Location"]
//   displayCourse()
  }
  
  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
    
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return courseVar.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(courseVar[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        setDetails()
        cell.textLabel?.text = courseVar[indexPath.row]
        cell.detailTextLabel?.text = courseDetails[indexPath.row]
        return cell
  }
    
    func setDetails()
    {
        courseDetails.append(NSUserDefaults.standardUserDefaults().valueForKey("Course")! as! String)
        courseDetails.append(NSUserDefaults.standardUserDefaults().valueForKey("CourseNumber")! as! String)
        courseDetails.append(NSUserDefaults.standardUserDefaults().valueForKey("Prof")! as! String)
        courseDetails.append(NSUserDefaults.standardUserDefaults().valueForKey("ProfEmail")! as! String)
        courseDetails.append(NSUserDefaults.standardUserDefaults().valueForKey("scheduale")! as! String)
        courseDetails.append(NSUserDefaults.standardUserDefaults().valueForKey("buildingName")! as! String)
    }
    

}