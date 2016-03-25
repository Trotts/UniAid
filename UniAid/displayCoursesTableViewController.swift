//
//  displayCoursesTableViewController.swift
//  Project-UniAid
//
//  Created by Amr Zokari on 2016-03-24.
//  Copyright © 2016 Amr Zokari. All rights reserved.
//

import UIKit
import CoreData

class displayCoursesTableViewController: UITableViewController {
    

    
    
   var returnCourses = [String]()
    
    //var returnCourses = ["Apple", "oranage"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       getCourses()
        //picker.delegate = self
        //picker.dataSource = self
        
        
        
        //courseLocationTextField.inputView = picker
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        
        
        
        
        if returnCourses.count > 0 {
            cell.textLabel?.text = returnCourses[indexPath.row]
        }
        else {
            cell.textLabel?.text = "No courses to display"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if returnCourses.count > 0 {
            return returnCourses.count
        }
        else {
            return 1
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("viewCourse", sender: self)

    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(returnCourses)
        
        
        
        if (segue.identifier == "viewCourse"){
            var newViewController: viewCourseDetails = segue.destinationViewController as! viewCourseDetails
            // let indexPath = self.tableView.indexPathForSelectedRow!
            
           // newViewController.titleTry = "amr"
            
            
            
            
            
            // indexPath is set to the path that was tapped
            
           // let indexPath = self.tableView.indexPathForSelectedRow!
            print("index path")
            //print(indexPath)
            // titleString is set to the title at the row in the objects array.
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
            
                let titleString = self.returnCourses[indexPath.row]
                newViewController.titleTry = titleString
                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)

            }
           /* else {
                let titleString = "amr"
                newViewController.titleTry = titleString
                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)

            }
          */
            
            
            // the titleStringViaSegue property of NewViewController is set.
            //newViewController.titleTry = titleString
           // self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            

            
            
            
        }
    }
    
    */
    //return courses
    func getCourses() {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //create a context
        //a handler for us to be able to access the database
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //retrive data
        //do that by creating a request
        let request = NSFetchRequest(entityName: "Course")
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.executeFetchRequest(request)
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    returnCourses.append(result.valueForKey("name") as! String)
                    
                }
            }
            
        }
        catch {
            print("error fetch failed ")
        }
        
        
    }
    

    
    
    


}
