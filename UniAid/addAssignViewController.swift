//
//  addAssignViewController.swift
//  Project-UniAid
//
//  Created by Amr Zokari on 2016-03-20.
//  Copyright © 2016 Amr Zokari. All rights reserved.
//

import UIKit
import CoreData

class addAssignViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
   
    @IBOutlet weak var assignNameTextField: UITextField!
   
    
    @IBOutlet weak var courseNameTextField: UITextField!
    
    
    //picker to handle time
    @IBOutlet weak var dueDateTextField: UITextField!
    
    
    @IBAction func dueDateTextField(sender: UITextField) {
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    //function to handle time
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        dueDateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    
    
    
    
    
    
    
    var emptylist = ["no courses"]
    var picker = UIPickerView()
    var returnCourses = [String]()
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       print("picker 1 first")
        if returnCourses.count > 0 {
            return returnCourses.count
        }
        else {
            return emptylist.count
        }
        
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if returnCourses.count > 0 {
            courseNameTextField.text = returnCourses[row]
        }
        else {
           courseNameTextField.text =  emptylist[row]
        }
      
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        print("picker 3 first")
        
        if returnCourses.count > 0 {
            return returnCourses[row]
        }
        else {
            return emptylist[row]
        }
    }

    
    @IBAction func addAssignButton(sender: AnyObject) {
        
        //we will use appDelegate to connect to our core data
        //this is the default app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //create a context
        //a handler for us to be able to access the database
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //add user to db
        //first we need to describe our entity that we would want to enter our user to
        let newAssign = NSEntityDescription.insertNewObjectForEntityForName("Assignment", inManagedObjectContext: context)
        
        newAssign.setValue(assignNameTextField.text, forKey: "name")
        newAssign.setValue(dueDateTextField.text, forKey: "dueDate")
        newAssign.setValue(courseNameTextField.text, forKey: "course")
        
        
        //now save it to the db
        //we do that be calling the context
        
        
        do {
            try context.save()
            let alert = UIAlertController(title: "Assignment Added", message: "Assignment was added Successfully", preferredStyle: UIAlertControllerStyle.Alert)
            
            let confirmAdd = UIAlertAction(title: "Great", style: UIAlertActionStyle.Cancel , handler: nil)
            
            
            alert.addAction(confirmAdd)
            
            
            showViewController(alert, sender: self)
            
            //clear text fields
            assignNameTextField.text = ""
            dueDateTextField.text = ""
            courseNameTextField.text = ""
            
            
            
            
            
        }
        catch {
            print("there was a problem")
        }
        
        
        
        
        //retrive data
        //do that by creating a request
        let request = NSFetchRequest(entityName: "Assignment")
        
        //u need this to actually return the data itself and not just info about it
        request.returnsObjectsAsFaults = false
        
        do {
            //now we need a var to store data that we get back from it
            let results = try context.executeFetchRequest(request)
            
            
            if results.count > 0 {
                print("Assignment Details")
                print(results.count)
                
                //by defualt results will contain ... therefore cast it
                for result in results as! [NSManagedObject] {
                    
                    //now we can access the info
                    print(result.valueForKey("name")!)
                    print(result.valueForKey("dueDate")!)
                    print(result.valueForKey("course")!)
                    
                    
                    
                    
                    
                    
                    
                }
            }
            
        }
        catch {
            print("error fetch failed ")
        }
        
        
        
        
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        getCourses()
        picker.delegate = self
        picker.dataSource = self
        
        
        courseNameTextField.inputView = picker
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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
