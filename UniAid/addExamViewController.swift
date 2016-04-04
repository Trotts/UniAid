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
    
    @IBOutlet var exam: UIButton!
    
    // Text Field Creation
    @IBOutlet weak var examNameTextField: UITextField!
    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBAction func dueDateTextField(sender: UITextField) {
        
        // Done and Cancel button
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePickerTime")
        doneButton.setTitleTextAttributes([NSFontAttributeName : UIFont.boldSystemFontOfSize(20.0),NSForegroundColorAttributeName : UIColor.orangeColor(),NSBackgroundColorAttributeName:UIColor.blackColor()],
                                          forState: UIControlState.Normal)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPickerTime")
        cancelButton.setTitleTextAttributes([NSFontAttributeName : UIFont.boldSystemFontOfSize(20.0),NSForegroundColorAttributeName : UIColor.orangeColor(),NSBackgroundColorAttributeName:UIColor.blackColor()],
                                            forState: UIControlState.Normal)
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
    
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        sender.inputView = datePickerView
        sender.inputAccessoryView = toolBar

        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }

    // MARK: Date and Time Handler
    
    // Handles the Date Picker
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        dueDateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    // Handles when user clicks Done
    func donePickerTime(){
        dueDateTextField.resignFirstResponder()
    }
    // Handles when user clicks Cancel
    func cancelPickerTime(){
        dueDateTextField.text = ""
        dueDateTextField.resignFirstResponder()
    }

        
    // MARK: Keyboard Handler
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: General Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exam.layer.cornerRadius = 12
        // Create Course Picker
        getCourses()
        picker.delegate = self
        picker.dataSource = self
        // Display Course Picker
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        doneButton.setTitleTextAttributes([NSFontAttributeName : UIFont.boldSystemFontOfSize(20.0),NSForegroundColorAttributeName : UIColor.orangeColor(),NSBackgroundColorAttributeName:UIColor.blackColor()],
                                          forState: UIControlState.Normal)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPicker")
        cancelButton.setTitleTextAttributes([NSFontAttributeName : UIFont.boldSystemFontOfSize(20.0),NSForegroundColorAttributeName : UIColor.orangeColor(),NSBackgroundColorAttributeName:UIColor.blackColor()],
                                            forState: UIControlState.Normal)
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
    
    // Number of components in the view (1 - keyboard)
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // Return the # of rows in each component
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if returnCourses.count > 0 {
            return returnCourses.count
        }
        else {
            return emptylist.count
        }
    }
    // Populates the rows
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if returnCourses.count > 0 {
            courseNameTextField.text = returnCourses[row]
        }
        else {
            courseNameTextField.text =  emptylist[row]
        }
    }
    // Return number of courses
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if returnCourses.count > 0 {
            return returnCourses[row]
        }
        else {
            return emptylist[row]
        }
    }

    // MARK: Button Handlers
    
    // Add Exam Button
    @IBAction func addExamButton(sender: UIButton) {
        // Connect to Core Data
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //Create a context (a handler for us to be able to access the database)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        // Add to Database
        let newExam = NSEntityDescription.insertNewObjectForEntityForName("Exam", inManagedObjectContext: context)
        
        newExam.setValue(examNameTextField.text, forKey: "name")
        newExam.setValue(dueDateTextField.text, forKey: "dueDate")
        newExam.setValue(courseNameTextField.text, forKey: "course")
        // Save to database
        do {
            try context.save()
            
            // Inform success
            let simpleAlert = UIAlertController(title: "Success", message: "Exam was added", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(simpleAlert, animated: true, completion: nil)
            
            // Show for two minutes without user input
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                simpleAlert.dismissViewControllerAnimated(true, completion: nil)
            })

            //clear text fields for next Exam input
            examNameTextField.text = ""
            dueDateTextField.text = ""
            courseNameTextField.text = ""
        }
        catch {
            print("There was a problem adding the exam")
        }
    }
    
    
    // Function to return courses
    func getCourses() {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Create a context (a handler for us to be able to access the database)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        // Retrieve data from Database
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
            print("Error fetch failed ")
        }
    }
    
    // Handles Done Button in Picker
    func donePicker(){
        courseNameTextField.resignFirstResponder()
    }
    // Handles Cancels Button in Picker
    func cancelPicker(){
        courseNameTextField.text = ""
        courseNameTextField.resignFirstResponder()
    }
}




