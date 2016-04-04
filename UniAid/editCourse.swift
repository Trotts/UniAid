//
//  editCourse.swift
//  UniAid
//
//  Created by Loai L. Felemban on 2016-04-01.
//  Copyright © 2016 igor epshtein. All rights reserved.
//
//

import UIKit
import CoreData


class EditCourseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate, UITextFieldDelegate {
    
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

    // MARK: Day Switches
    
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
    
    // Function to reset the fields after the submission to Database
    @IBAction func resetClicked() {
        mondaySwitch.setOn(false, animated: true);
        tuesdaySwitch.setOn(false, animated: true);
        wednesdaySwitch.setOn(false, animated: true);
        thursdaySwitch.setOn(false, animated: true);
        fridaySwitch.setOn(false, animated: true);
    }
  
    // Hold days for the course
    var daysSelectedArr = [String]()
    // Holds the Dal Buildings
    var buildings = ["Dentistry Building","Goldberg Computer Science Building","Howe Hall","Boulden Building","Burbidge Building","Chase Building","Chemical Engineering","Chemistry","Kenneth C. Rowe Management Building","Killam Library","Life Sciences Centre","Marion McCain Arts and Social Sciences","Mona Campbell Building","Dalhousie Arts Centre","Dalplex","Sir James Dunn Building","Student Union Building","Weldon Law Building","Tupper Building"]
    
    // Picker for the location
    var picker = UIPickerView()
    
    
    // MARK: Time Functions
    @IBOutlet weak var timeFromTextField: UITextField!
    @IBOutlet weak var timeToTextField: UITextField!
    
    
    
    // Handles From Time
    @IBAction func timeFromTextField(sender: UITextField) {
    
        // Create and show Done and Cancel buttons
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

        
        // Create the Date and Time Picker
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        sender.inputAccessoryView = toolBar

        datePickerView.addTarget(self, action: Selector("handleFromTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    // Handle the From Time Picker
    func handleFromTimePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        timeFromTextField.text = timeFormatter.stringFromDate(sender.date)
    }
    // What to do when the user clicks Done
    func donePickerTimeFor(){
        timeFromTextField.resignFirstResponder()
    }
    // What to do when the user clicks Cancel
    func cancelPickerTimeFor(){
        timeFromTextField.text = ""
        timeFromTextField.resignFirstResponder()
    }
    
    // Handles To Time
    @IBAction func timeToTextField(sender: UITextField) {
       
        
        // Create and Show Done and Cancel Buttons
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
   
        // Handle the Date and Time Picker
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        sender.inputAccessoryView = toolBar

        datePickerView.addTarget(self, action: Selector("handleToTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // Handle To Time
    func handleToTimePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        timeToTextField.text = timeFormatter.stringFromDate(sender.date)
    }
    // Handle what to do when the user clicks Done
    func donePickerTimeTo(){
        timeToTextField.resignFirstResponder()
    }
    // What to do when the user clicks Cancel
    func cancelPickerTimeTo(){
        timeToTextField.text = ""
        timeToTextField.resignFirstResponder()
    }
   
    // MARK: View Slider Handler
    
    // Move the View up when the user clicks a text field which will be blocked by the keyboard
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == profNameTextField || textField == profEmailTextField) {
            animateViewMoving(true, moveValue: 130)
        }
        if (textField == timeToTextField){
            animateViewMoving(true, moveValue: 30)
        }
    }
    // Move back when the user is done
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField == profNameTextField || textField == profEmailTextField) {
            animateViewMoving(false, moveValue: 130)
        }
        if (textField == timeToTextField){
            animateViewMoving(false, moveValue: 30)
        }
    }
    // Handles the moving
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    

    // MARK: Keyboard Functions
    
    // Function to handle keyboard disappearing
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    // Return the number of components (1 - keyboard)
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    // Returns the # of rows in each component
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return buildings.count
       
    }
    // Populate the text fields with the building names
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            courseLocationTextField.text = buildings[row]
    }
    // Return the buildings
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return buildings[row]
    }
    

    // MARK: Save Button

    @IBAction func saveButton(sender: AnyObject) {
        
        // Get the dates of the class from the user
        var daysSelected = ""
        for r in daysSelectedArr {
            daysSelected += r + "."
        }
      
        // Connect to Core Data
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Create a context (a handler for us to be able to access the database)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "Course")

        // Make sure that the email is correct and in the right format, if not then show alert and return
        if !isValidEmail(profEmailTextField.text!)
        {
            let simpleAlert = UIAlertController(title: "Wrong Email", message: "Please enter a correct email address", preferredStyle: UIAlertControllerStyle.Alert)
            
            // Show the error
            self.presentViewController(simpleAlert, animated: true, completion: nil)
            
            // Appear for two minutes without user input
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                simpleAlert.dismissViewControllerAnimated(true, completion: nil)
            })
            return
        }
        do {
          
          let resault : NSArray = try context.executeFetchRequest(request)
          if(resault.count > 0){
            
            let courseData = resault [NSUserDefaults.standardUserDefaults().valueForKey("rowNum") as! Int ] as! NSManagedObject
            
            courseData.setValue(courseNameTextField.text, forKey: "name")
            courseData.setValue(courseNumTextField.text, forKey: "number")
            courseData.setValue(courseLocationTextField.text, forKey: "location")
            courseData.setValue(timeFromTextField.text, forKey: "timeFrom")
            courseData.setValue(timeToTextField.text, forKey: "timeTo")
            courseData.setValue(profNameTextField.text, forKey: "profName")
            courseData.setValue(profEmailTextField.text, forKey: "profEmail")
          }
          else
          {
            print("Error setting values")
          }
            try context.save()
            
            // Inform the user that course has been saved successfully
            let simpleAlert = UIAlertController(title: "Success", message: "Course was Edited", preferredStyle: UIAlertControllerStyle.Alert)
            
            // Show alert
            self.presentViewController(simpleAlert, animated: true, completion: nil)
            
            // Let it appear for two minutes unless user input
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                simpleAlert.dismissViewControllerAnimated(true, completion: nil)
            })
        }
        catch {
            print("There was a problem saving to the Database")
        }
      
  }
    
    // Validate the email
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
        
    }
    
    // MARK: General Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        buildings.sortInPlace()
        
        showInfo()
        picker.delegate = self
        picker.dataSource = self
       
        // Display the Buildings Picker
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
    
    
    // Handle the Done and the Cancel buttons
    func donePicker(){
        courseLocationTextField.resignFirstResponder()
    }
    func cancelPicker(){
        courseLocationTextField.text = ""
        courseLocationTextField.resignFirstResponder()
    }
    
   // Display the course data in the text Field to be edited
  func showInfo() {
    
    // Connect to Core Data
    let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // Create a context (a handler for us to be able to access the database)
    let context: NSManagedObjectContext = appDel.managedObjectContext
  
    let request = NSFetchRequest(entityName: "Course")
    request.returnsObjectsAsFaults = false
    do
    {
      let resault : NSArray = try context.executeFetchRequest(request)
      if(resault.count > 0){
        
        let courseData = resault [NSUserDefaults.standardUserDefaults().valueForKey("rowNum") as! Int ] as! NSManagedObject
        
        courseNameTextField.text = (courseData.valueForKey("name") as! String)
        courseNumTextField.text = (courseData.valueForKey("number") as! String)
        profNameTextField.text = (courseData.valueForKey("profName") as! String)
        profEmailTextField.text = (courseData.valueForKey("profEmail") as! String)
        courseLocationTextField.text = (courseData.valueForKey("location") as! String)
        
      }
      else
      {
        print("Error adding to Database")
      }
    }
    catch {
      print("Error fetch failed ")
    }
  }
}
