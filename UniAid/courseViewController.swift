//
//  ViewController.swift
//  Project-UniAid
//
//  Created by Amr Zokari on 2016-03-13.
//  Edited by Loai L. Felemban
//  Copyright © 2016 Amr Zokari. All rights reserved.
//
//

import UIKit
import CoreData


class courseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
  
  // Button for NavBar
  @IBOutlet var open: UIBarButtonItem!
  @IBOutlet var details: UITableView!
 
  var courseInfo = [String]()
  var dataTitle = ["Course Name","Course Number","Professor Name","Professor Email","Location"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getData()
    
    // Allows for the inclusion of the Navigation Menu
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        self.details.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // Gets the data stored in NSUserDefault
  func getData(){
    let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    let context: NSManagedObjectContext = appDel.managedObjectContext
    
    
    let request = NSFetchRequest(entityName: "Course")
    request.returnsObjectsAsFaults = false
    do
    {
      let resault : NSArray = try context.executeFetchRequest(request)
      if(resault.count > 0){
        if(NSUserDefaults.standardUserDefaults().valueForKey("fromMain") as! Int == 1)
        {
            courseInfo.append(NSUserDefaults.standardUserDefaults().valueForKey("name") as! String)
            courseInfo.append(NSUserDefaults.standardUserDefaults().valueForKey("number") as! String)
            courseInfo.append(NSUserDefaults.standardUserDefaults().valueForKey("profName") as! String)
            courseInfo.append(NSUserDefaults.standardUserDefaults().valueForKey("profEmail") as! String)
            courseInfo.append(NSUserDefaults.standardUserDefaults().valueForKey("location") as! String)
           
        }
        else
        {
            let courseData = resault [NSUserDefaults.standardUserDefaults().valueForKey("rowNum") as! Int ] as! NSManagedObject
            
            courseInfo.append(courseData.valueForKey("name") as! String)
            courseInfo.append(courseData.valueForKey("number") as! String)
            courseInfo.append(courseData.valueForKey("profName") as! String)
            courseInfo.append(courseData.valueForKey("profEmail") as! String)
            courseInfo.append(courseData.valueForKey("location") as! String)
        }
      }
      else
      {
        print("Error: NSUserDefault")
      }
    }
    catch {
      print("Error fetch failed ")
    }
  }
 
  // Sets the number of sections in the table to 1
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  // Retunrs the number of course info
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return courseInfo.count
  }

  // Populates the cells
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.details.dequeueReusableCellWithIdentifier("CourseInfoCell", forIndexPath: indexPath) as! CourseInfo
   
    cell.courseInfo.text = courseInfo[indexPath.row]
    cell.detailTextLabel?.text = dataTitle[indexPath.row]
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    
    return cell
  }


}