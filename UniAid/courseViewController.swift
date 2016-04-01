//
//  ViewController.swift
//  Project-UniAid
//
//  Created by Amr Zokari on 2016-03-13.
//  Copyright © 2016 Amr Zokari. All rights reserved.
//

import UIKit
import CoreData


class courseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
  
  //Button for NavBar
  @IBOutlet var open: UIBarButtonItem!
  @IBOutlet var details: UITableView!
 
  let ReuseIdentifierCourseCell = "CourseInfoCell"
  var managedObjectContext: NSManagedObjectContext!
  
  lazy var fetchedResultsController: NSFetchedResultsController = {
    // initialize fetch request
    let fetchRequest = NSFetchRequest(entityName: "Course")
    
    // Add Sort
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    // init fetch result
    let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    
    // Configure
    fetchResultsController.delegate = self
    
    return fetchResultsController
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    getData()
    
    // Allows for the inclusion of the Navigation Menu
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        self.details.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
   
    do {
      try self.fetchedResultsController.performFetch()
    } catch {
      let fetchError = error as NSError
      print("\(fetchError), \(fetchError.userInfo)")
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func getData(){
    let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    managedObjectContext = appDel.managedObjectContext
  }

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    if let sections = fetchedResultsController.sections {
      return sections.count
    }
    return 0
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let sections = fetchedResultsController.sections {
      let currentSection = sections[section]
      return currentSection.numberOfObjects
    }
    return 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.details.dequeueReusableCellWithIdentifier("CourseInfoCell", forIndexPath: indexPath) as! CourseInfo
   
    configureCell(cell, atIndexPath: indexPath)
    
    return cell
  }
  
  func configureCell(cell: CourseInfo, atIndexPath indexPath: NSIndexPath) {
    let data = fetchedResultsController.objectAtIndexPath(indexPath)
    
    if let courseName = data.valueForKey("name") as? String {
      cell.name.text = courseName
    }
    
    if let courseNumber = data.valueForKey("number") as? String {
      cell.number.text = courseNumber
    }
  }
}