//
//  ViewController.swift
//  Project-UniAid
//
//  Created by Amr Zokari on 2016-03-13.
//  Copyright © 2016 Amr Zokari. All rights reserved.
//

import UIKit
import CoreData


class addCourseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate, UITextFieldDelegate {
    
    
    // Textfields
    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var courseNumTextField: UITextField!
    @IBOutlet weak var courseLocationTextField: UITextField!
    @IBOutlet weak var profNameTextField: UITextField!
    @IBOutlet weak var profEmailTextField: UITextField!
    // Switches
    @IBOutlet weak var mondaySwitch: UISwitch!
    @IBOutlet weak var tuesdaySwitch: UISwitch!
    @IBOutlet weak var wednesdaySwitch: UISwitch!
    @IBOutlet weak var thursdaySwitch: UISwitch!
    @IBOutlet weak var fridaySwitch: UISwitch!
    
    
    // MARK: Day Switches Handlers
    
    // Monday
    @IBAction func mondaySwitchChanged(sender: AnyObject) {
        if mondaySwitch.on {
            if !daysSelectedArr.contains("Monday") {
                daysSelectedArr.append("Monday")
            }
        }
        else {
            if daysSelectedArr.contains("Monday"){
                let indexReturn = daysSelectedArr.indexOf("Monday")
                daysSelectedArr.removeAtIndex(indexReturn!)
            }
        }
    }
    
    // Tuesday
    @IBAction func tuesdaySwitchChanged(sender: AnyObject) {
        if tuesdaySwitch.on {
            if !daysSelectedArr.contains("Tuesday") {
                daysSelectedArr.append("Tuesday")
            }
        }
        else {
            if daysSelectedArr.contains("Tuesday"){
                let indexReturn = daysSelectedArr.indexOf("Tuesday")
                daysSelectedArr.removeAtIndex(indexReturn!)
            }
        }
    }
    
    // Wednesday
    @IBAction func wednesdaySwitchChanged(sender: AnyObject) {
        if wednesdaySwitch.on {
            if !daysSelectedArr.contains("Wednesday") {
                daysSelectedArr.append("Wednesday")
            }
        }
        else {
            if daysSelectedArr.contains("Wednesday"){
                let indexReturn = daysSelectedArr.indexOf("Wednesday")
                daysSelectedArr.removeAtIndex(indexReturn!)
            }
        }
    }
    
    // Thursday
    @IBAction func thursdaySwitchChanged(sender: AnyObject) {
        if thursdaySwitch.on {
            if !daysSelectedArr.contains("Thursday") {
                daysSelectedArr.append("Thursday")
            }
        }
        else {
            if daysSelectedArr.contains("Thursday"){
                let indexReturn = daysSelectedArr.indexOf("Thursday")
                daysSelectedArr.removeAtIndex(indexReturn!)
            }
        }
    }
    
    // Friday
    @IBAction func fridaySwitchChanged(sender: AnyObject) {
        if fridaySwitch.on {
            if !daysSelectedArr.contains("Friday") {
                daysSelectedArr.append("Friday")
            }
        }
            
            
        else {
            if daysSelectedArr.contains("Friday"){
                let indexReturn = daysSelectedArr.indexOf("Friday")
                daysSelectedArr.removeAtIndex(indexReturn!)
            }
        }
    }
    
    // Reset switches after the user resets
    @IBAction func resetClicked() {
        mondaySwitch.setOn(false, animated: true);
        tuesdaySwitch.setOn(false, animated: true);
        wednesdaySwitch.setOn(false, animated: true);
        thursdaySwitch.setOn(false, animated: true);
        fridaySwitch.setOn(false, animated: true);
    }
    
    // Records the days for a course
    var daysSelectedArr = [String]()
    // List of Dal Buildings
    var buildings = ["Dentistry Building","Goldberg Computer Science Building","Howe Hall","Boulden Building","Burbidge Building","Chase Building","Chemical Engineering","Chemistry","Kenneth C. Rowe Management Building","Killam Library","Life Sciences Centre","Marion McCain Arts and Social Sciences","Mona Campbell Building","Dalhousie Arts Centre","Dalplex","Sir James Dunn Building","Student Union Building","Weldon Law Building","Tupper Building"]
    // Picker for the location
    var picker = UIPickerView()
    
    
    
    // MARK: Time Switches Handlers
    @IBOutlet weak var timeFromTextField: UITextField!
    @IBOutlet weak var timeToTextField: UITextField!
    
    // From Time Function
    @IBAction func timeFromTextField(sender: UITextField) {
        // Create Done and Cancel Buttons
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePickerTimeFor")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPickerTimeFor")
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true

        // Create date Picker View
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        sender.inputAccessoryView = toolBar

        datePickerView.addTarget(self, action: Selector("handleFromTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // Handles the From Time Picker
    func handleFromTimePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        timeFromTextField.text = timeFormatter.stringFromDate(sender.date)
    }
    // What to do when the From Time is picked
    func donePickerTimeFor(){
        timeFromTextField.resignFirstResponder()
    }
    // What to do when the From Time is Cancelled out of
    func cancelPickerTimeFor(){
        timeFromTextField.text = ""
        timeFromTextField.resignFirstResponder()
    }
   
    // To Time Function
    @IBAction func timeToTextField(sender: UITextField) {
        // Create Done and Cancel Buttons
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePickerTimeTo")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPickerTimeTo")
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
   
        // Create Date Picker View
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        sender.inputAccessoryView = toolBar

        datePickerView.addTarget(self, action: Selector("handleToTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    // Handles the To Time Picker
    func handleToTimePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        timeToTextField.text = timeFormatter.stringFromDate(sender.date)
    }
    
    // What to do when To Date Picker is picked
    func donePickerTimeTo(){
        timeToTextField.resignFirstResponder()
    }
    // What to do when the To Date Picker is cancelled out of
    func cancelPickerTimeTo(){
        timeToTextField.text = ""
        timeToTextField.resignFirstResponder()
    }
    

    // MARK: Page Sliding Functions
    
    // Function to slide the page if text box below the keyboard boundry is selected
    func textFieldDidBeginEditing(textField: UITextField) {
        // Prof Name and Prof Email Text Fields
        if (textField == profNameTextField || textField == profEmailTextField) {
            animateViewMoving(true, moveValue: 130)
        }
        // Time To Text Field
        if (textField == timeToTextField){
            animateViewMoving(true, moveValue: 30)
        }
    }
    // Function to slide back down when finished
    func textFieldDidEndEditing(textField: UITextField) {
        // Prod Name and Prof Email Text Fields
        if (textField == profNameTextField || textField == profEmailTextField) {
            animateViewMoving(false, moveValue: 130)
        }
        // Time To Text Field
        if (textField == timeToTextField){
            animateViewMoving(false, moveValue: 30)
        }
    }

    // Controls the movement of the View
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
  
    // MARK: Keyboard Handler
    
    // Remove keyboard on end
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    // Number of components in the View (1 - keyboard)
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Returns the # of rows in each component
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return buildings.count
       
    }
    // Populates the text for the building rows
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            courseLocationTextField.text = buildings[row]
    }
    // Return building names
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return buildings[row]
    }
    
    // MARK: Add a Course Button Handler
    
    // Get the Date of the class from the user and store them
    @IBAction func addCourseButton(sender: AnyObject) {
        var daysSelected = ""
        for r in daysSelectedArr {
            daysSelected += r + "."
        }
        
        // Connect to Core Data
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Create a context (a handler for us to be able to access the database)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        // Add class to Database
        let profEmail = profEmailTextField.text
        let profName = profNameTextField.text
        let courseName = courseNameTextField.text
        let courseNum = courseNumTextField.text
        let courseLocation = courseLocationTextField.text
        let schedule = daysSelected
        let timeFrom = timeFromTextField.text
        let timeTo = timeToTextField.text
        
        
        // User Input Validation
        
        // First: Start by making sure that all fields are entered, if not then show alert and return
        if (profName == "" || courseName == "" || courseNum == "" || courseLocation == "" || schedule.isEmpty || timeFrom == "" || timeTo == ""){
            // Create error
            let emptyAlert = UIAlertController(title: "Empty Fields", message: "Please enter all fields", preferredStyle: UIAlertControllerStyle.Alert)
            // Show error
            self.presentViewController(emptyAlert, animated: true, completion: nil)
            
            // Appear for two minutes without user cancelling
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                emptyAlert.dismissViewControllerAnimated(true, completion: nil)
            })
            return
        }
        
        // Second: Make sure that the email is correct and in the right format, if not then show alert and return
        if !isValidEmail(profEmailTextField.text!)
        {
            // Create error
            let simpleAlert = UIAlertController(title: "Wrong Email", message: "Please enter a correct email address", preferredStyle: UIAlertControllerStyle.Alert)
            // Show error
            self.presentViewController(simpleAlert, animated: true, completion: nil)
            
            // Appear for two minutes without user cancelling
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                simpleAlert.dismissViewControllerAnimated(true, completion: nil)
            })
            return
        }
        
        // Finally: If the previous two steps successed then put everything inside the database
        do {
          
            let newCourse = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: context)
          
            newCourse.setValue(courseNameTextField.text, forKey: "name")
            newCourse.setValue(courseNumTextField.text, forKey: "number")
            newCourse.setValue(courseLocationTextField.text, forKey: "location")
            newCourse.setValue(daysSelected, forKey: "days")
            newCourse.setValue(timeFromTextField.text, forKey: "timeFrom")
            newCourse.setValue(timeToTextField.text, forKey: "timeTo")
            newCourse.setValue(profNameTextField.text, forKey: "profName")
            newCourse.setValue(profEmailTextField.text, forKey: "profEmail")

            
            try context.save()
            
            // Inform the user that it has been saved successfully
            let simpleAlert = UIAlertController(title: "Success", message: "Course was added", preferredStyle: UIAlertControllerStyle.Alert)
            
            // Confirmation
            self.presentViewController(simpleAlert, animated: true, completion: nil)
            
            // Appear for two minutes without user cancelling
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                simpleAlert.dismissViewControllerAnimated(true, completion: nil)
            })

            // Clear the text fields for new course addition
            courseNameTextField.text = ""
            courseNumTextField.text = ""
            courseLocationTextField.text = ""
            timeFromTextField.text = ""
            timeToTextField.text = ""
            profNameTextField.text = ""
            profEmailTextField.text = ""
            resetClicked()
        }
        catch {
            print("There was a problem with user input")
            
        }
    }
    
    // Email validation
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    
    // MARK: Required Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create Builder Picker
        picker.delegate = self
        picker.dataSource = self
        
        // Display Building Picker
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
    
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelPicker")

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true

        courseLocationTextField.inputView = picker
        courseLocationTextField.inputAccessoryView = toolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Handle Done Button
    func donePicker(){
        courseLocationTextField.resignFirstResponder()
    }
    // Handle Cancel Button
    func cancelPicker(){
        courseLocationTextField.text = ""
        courseLocationTextField.resignFirstResponder()
    }


}

