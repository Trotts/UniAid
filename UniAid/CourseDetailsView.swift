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

  override func viewDidLoad() {
    super.viewDidLoad()
    
    open.target = self.revealViewController()
    open.action = Selector("revealToggle:")
    
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
  
    details.delegate = self
    details.dataSource = self
    
    courseVar = ["Name", "Number", "Inst. Name", "Inst. Email", "Schedule", "Location"]
   displayCourse()
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
        cell.textLabel?.text = courseVar[indexPath.row]
        return cell
  }
    
    func displayCourse(){
        
        //we will use appDelegate to connect to our core data
        //this is the default app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //create a context
        //a handler for us to be able to access the database
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //add user to db
        //first we need to describe our entity that we would want to enter our user to
        var newCourse = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: context)

        
        //retrive data
        //do that by creating a request
        let request = NSFetchRequest(entityName: "Course")
        
        //u need this to actually return the data itself and not just info about it
        request.returnsObjectsAsFaults = false
        
        do {
            //now we need a var to store data that we get back from it
            let results = try context.executeFetchRequest(request)
            
            
            if results.count > 0 {
                print("Course Details")
                print(results.count)
                
                //by defualt results will contain ... therefore cast it
                for result in results as! [NSManagedObject] {
                    
                    courseVar[1] = "amr"
                    //now we can access the info
                    
                    /*
                    print(result.valueForKey("name")!)
                    print(result.valueForKey("number")!)
                    print(result.valueForKey("location")!)
                    print(result.valueForKey("days")!)
                    print(result.valueForKey("timeFrom")!)
                    print(result.valueForKey("timeTo")!)
                    print(result.valueForKey("profName")!)
                    print(result.valueForKey("profEmail")!)
                    */
                    
                    print("Found ya loai")
                    
                    
                    
                    
                    
                    
                }
            }
            
        }
        catch {
            print("error fetch failed ")
        }
        
        

        
        
        
        
        
    }
    

}