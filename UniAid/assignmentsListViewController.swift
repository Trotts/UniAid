//
//  assignmentsListViewController.swift
//  UniAid
//
//  Created by Loai L. Felemban on 2016-04-01.
//  Copyright © 2016 igor epshtein. All rights reserved.
//
//

import UIKit
import CoreData

class AssignmentListViewController: UITableViewController {
    
   var returnAssignments = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       getAssignments()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Set number of rows
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSUserDefaults.standardUserDefaults().setValue(indexPath.row, forKey: "rowNum")
    }
    // Populate the cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        if returnAssignments.count > 0 {
            cell.textLabel?.text = returnAssignments[indexPath.row]
        }
        else {
            cell.textLabel?.text = "No Assignments to display"
        }
        return cell
    }
    // Return number of cells
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if returnAssignments.count > 0 {
            return returnAssignments.count
        }
        else {
            return 1
        }
    }
    
    // Return assignments
    func getAssignments() {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Create a context (a handler for us to be able to access the database)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        // Retrive data
        let request = NSFetchRequest(entityName: "Assignment")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.executeFetchRequest(request)
            if results.count > 0 {
              
              let assignmentData = results [NSUserDefaults.standardUserDefaults().valueForKey("rowNum") as! Int ] as! NSManagedObject
              
              returnAssignments.append(assignmentData.valueForKey("course") as! String)
              returnAssignments.append(assignmentData.valueForKey("dueDate") as! String)
              returnAssignments.append(assignmentData.valueForKey("name") as! String)
            }
        }
        catch {
            print("Error fetch failed ")
        }
    }
}
