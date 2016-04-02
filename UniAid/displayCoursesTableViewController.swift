//
//  displayCoursesTableViewController.swift
//  Project-UniAid
//
//  Created by Amr Zokari on 2016-03-24.
//  Copyright © 2016 Amr Zokari. All rights reserved.
//
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSUserDefaults.standardUserDefaults().setValue(indexPath.row, forKey: "rowNum")
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
