//
//  addExamViewController.swift
//  Project-UniAid
//
//  Created by Amr Zokari on 2016-03-24.
//  Copyright © 2016 Amr Zokari. All rights reserved.
//

import UIKit
import CoreData

class addExamViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate  {
    
    
    @IBOutlet weak var examNameTextField: UITextField!
    
    
    @IBOutlet weak var courseNameTextField: UITextField!
    
    
    @IBOutlet weak var dueDateTextField: UITextField!
    
    @IBAction func dueDateTextField(sender: UITextField) {
        
        //done and cancel button
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePickerTime")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPickerTime")
        
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
    
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        sender.inputView = datePickerView
        sender.inputAccessoryView = toolBar

        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    //
    //function to handle time
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        dueDateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    func donePickerTime(){
        dueDateTextField.resignFirstResponder()
    }
    
    func cancelPickerTime(){
        dueDateTextField.text = ""
        dueDateTextField.resignFirstResponder()
    }

        
    //Function to handle keyboard disappearing
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        getCourses()
        picker.delegate = self
        picker.dataSource = self
  
        
        //the following will be used to display the courses picker view with a "done" and a "cancel" buttons
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPicker")
        
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true

        
        courseNameTextField.inputView = picker
        courseNameTextField.inputAccessoryView = toolBar
     
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    var emptylist = ["no courses"]
    var picker = UIPickerView()
    var returnCourses = [String]()
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
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
        
        if returnCourses.count > 0 {
            return returnCourses[row]
        }
        else {
            return emptylist[row]
        }
    }

    
    
    
    //add exam button
    
    @IBAction func addExamButton(sender: UIButton) {
        
        
        
        //we will use appDelegate to connect to our core data
        //this is the default app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //create a context
        //a handler for us to be able to access the database
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //add user to db
        //first we need to describe our entity that we would want to enter our user to
        let newExam = NSEntityDescription.insertNewObjectForEntityForName("Exam", inManagedObjectContext: context)
        
        newExam.setValue(examNameTextField.text, forKey: "name")
        newExam.setValue(dueDateTextField.text, forKey: "dueDate")
        newExam.setValue(courseNameTextField.text, forKey: "course")
        
        
        //now save it to the db
        //we do that be calling the context
        
        
        do {
            try context.save()
            
            //inform the user that it has been saved successfully
            let simpleAlert = UIAlertController(title: "Success", message: "Exam was added", preferredStyle: UIAlertControllerStyle.Alert)
            
            //show it
            //showViewController(simpleAlert, sender: self);
            self.presentViewController(simpleAlert, animated: true, completion: nil)
            
            //let it appear for two minutes
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                simpleAlert.dismissViewControllerAnimated(true, completion: nil)
            })

            
            //clear text fields
            examNameTextField.text = ""
            dueDateTextField.text = ""
            courseNameTextField.text = ""
            
            
            
            
            
        }
        catch {
            print("there was a problem")
        }
        
        
        
        /************************************************/
        /* For Testing purpose only, we retrieve the data */
        /************************************************/

         
        //retrive data
        //do that by creating a request
        let request = NSFetchRequest(entityName: "Exam")
        
        //u need this to actually return the data itself and not just info about it
        request.returnsObjectsAsFaults = false
        
        do {
            //now we need a var to store data that we get back from it
            let results = try context.executeFetchRequest(request)
            
            
            if results.count > 0 {
                print("Exam Details")
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
    
    
    //function to return courses
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
    
    //these two functions will handle the done and the cancel buttons on the courses picker
    func donePicker(){
        courseNameTextField.resignFirstResponder()
    }
    
    func cancelPicker(){
        courseNameTextField.text = ""
        courseNameTextField.resignFirstResponder()
    }


    
    
}




