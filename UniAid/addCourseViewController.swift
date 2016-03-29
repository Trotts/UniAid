//
//  ViewController.swift
//  Project-UniAid
//
//  Created by Amr Zokari on 2016-03-13.
//  Copyright © 2016 Amr Zokari. All rights reserved.
//

import UIKit
import CoreData


class addCourseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate {
    
    
    
    
    
    
    //textfields
    @IBOutlet weak var courseNameTextField: UITextField!
    
    @IBOutlet weak var courseNumTextField: UITextField! 
   
    @IBOutlet weak var courseLocationTextField: UITextField!

    @IBOutlet weak var profNameTextField: UITextField!
    
    @IBOutlet weak var profEmailTextField: UITextField!
    
    
    
    
    //switches
    
    @IBOutlet weak var mondaySwitch: UISwitch!
    
    @IBOutlet weak var tuesdaySwitch: UISwitch!
   
    @IBOutlet weak var wednesdaySwitch: UISwitch!
    
    @IBOutlet weak var thursdaySwitch: UISwitch!
    
    @IBOutlet weak var fridaySwitch: UISwitch!
    
    
    
    
    //handle switches for each day
    //Monday switch changed
    @IBAction func mondaySwitchChanged(sender: AnyObject) {
        
        if mondaySwitch.on {
            print("Monday changed to on")
           
          
            if !daysSelectedArr.contains("Monday") {
                daysSelectedArr.append("Monday")
            }
            
        }
        
        
        else {
            if daysSelectedArr.contains("Monday"){
                let indexReturn = daysSelectedArr.indexOf("Monday")
                daysSelectedArr.removeAtIndex(indexReturn!)
                
            }
            
             print("Monday changed to off")
        }
        
        print("Array:")
        print(daysSelectedArr)
    }
    
    //Tuesday switch changed
    @IBAction func tuesdaySwitchChanged(sender: AnyObject) {
        if tuesdaySwitch.on {
            print("Tuesday changed to on")
            
            
            if !daysSelectedArr.contains("Tuesday") {
                daysSelectedArr.append("Tuesday")
            }
            
        }
            
            
        else {
            if daysSelectedArr.contains("Tuesday"){
                let indexReturn = daysSelectedArr.indexOf("Tuesday")
                daysSelectedArr.removeAtIndex(indexReturn!)
                
            }
            
            print("Tuesday changed to off")
        }
        
        print("Array:")
        print(daysSelectedArr)
    }
    
    //Wednesday switch changed
    @IBAction func wednesdaySwitchChanged(sender: AnyObject) {
        if wednesdaySwitch.on {
            print("Wednesday changed to on")
            
            
            if !daysSelectedArr.contains("Wednesday") {
                daysSelectedArr.append("Wednesday")
            }
            
        }
            
            
        else {
            if daysSelectedArr.contains("Wednesday"){
                let indexReturn = daysSelectedArr.indexOf("Wednesday")
                daysSelectedArr.removeAtIndex(indexReturn!)
                
            }
            
            print("Wednesday changed to off")
        }
        
        print("Array:")
        print(daysSelectedArr)

    }
    
    //Thursday switch changed
    @IBAction func thursdaySwitchChanged(sender: AnyObject) {
        if thursdaySwitch.on {
            print("Thursday changed to on")
            
            
            if !daysSelectedArr.contains("Thursday") {
                daysSelectedArr.append("Thursday")
            }
            
        }
            
            
        else {
            if daysSelectedArr.contains("Thursday"){
                let indexReturn = daysSelectedArr.indexOf("Thursday")
                daysSelectedArr.removeAtIndex(indexReturn!)
                
            }
            
            print("Thursday changed to off")
        }
        
        print("Array:")
        print(daysSelectedArr)
    }
    
    //Friday switch changed
    @IBAction func fridaySwitchChanged(sender: AnyObject) {
        if fridaySwitch.on {
            print("Friday changed to on")
            
            
            if !daysSelectedArr.contains("Friday") {
                daysSelectedArr.append("Friday")
            }
            
        }
            
            
        else {
            if daysSelectedArr.contains("Friday"){
                let indexReturn = daysSelectedArr.indexOf("Friday")
                daysSelectedArr.removeAtIndex(indexReturn!)
                
            }
            
            print("Friday changed to off")
        }
        
        print("Array:")
        print(daysSelectedArr)
    }
    
  // Comment
  
    
    //var daysOfWeekSelected = ""
    
    var daysSelectedArr = [String]()
    
    var buildings = ["Dentistry Building","Goldberg Computer Science Building","Howe Hall","Boulden Building","Burbidge Building","Chase Building","Chemical Engineering","Chemistry","Kenneth C. Rowe Management Building","Killam Library","Life Sciences Centre","Marion McCain Arts and Social Sciences","Mona Campbell Building","Dalhousie Arts Centre","Dalplex","Sir James Dunn Building","Student Union Building","Weldon Law Building","Tupper Building"]
   
    
    
    var picker = UIPickerView()
    
    
    
    
    /*******************************************************/
    //new picker for time
    
    
    
    //Time of classes code starts here
    
    @IBOutlet weak var timeFromTextField: UITextField!
    
    @IBOutlet weak var timeToTextField: UITextField!
    
    //functions to handle time - from
    @IBAction func timeFromTextField(sender: UITextField) {
        
        //done and cancel button
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(addCourseViewController.donePickerTimeFor))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(addCourseViewController.cancelPickerTimeFor))
        
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true

        
        //handle the time
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        sender.inputAccessoryView = toolBar

        datePickerView.addTarget(self, action: #selector(addCourseViewController.handleFromTimePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func handleFromTimePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        timeFromTextField.text = timeFormatter.stringFromDate(sender.date)
    }
    
    func donePickerTimeFor(){
        timeFromTextField.resignFirstResponder()
    }
    
    func cancelPickerTimeFor(){
        timeFromTextField.text = ""
        timeFromTextField.resignFirstResponder()
    }
    
    //functions to handle time - to
    @IBAction func timeToTextField(sender: UITextField) {
        
        //done and cancel button
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(addCourseViewController.donePickerTimeTo))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(addCourseViewController.cancelPickerTimeTo))
        
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true

        
        
        
        //handle the time
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        sender.inputAccessoryView = toolBar

        datePickerView.addTarget(self, action: #selector(addCourseViewController.handleToTimePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
       // timeToTextField.endEditing(true)
        
    }
    
    
    func handleToTimePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        timeToTextField.text = timeFormatter.stringFromDate(sender.date)
        
    }
    
    
    func donePickerTimeTo(){
        timeToTextField.resignFirstResponder()
    }
    
    func cancelPickerTimeTo(){
        timeToTextField.text = ""
        timeToTextField.resignFirstResponder()
    }
    
    
    //end of time functions and pickers
    
    
   
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    // returns the # of rows in each component..

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return buildings.count
       
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            courseLocationTextField.text = buildings[row]
           // courseLocationLabel.text = buildings[row]
        
        
       //courseLocationTextField.endEditing(true)
        
        
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return buildings[row]
    }
    
    
    
    //Add a cousre action
    @IBAction func addCourseButton(sender: AnyObject) {
        
        //get the dates of the class from the user and store them inside a var (string)
        var daysSelected = ""
        
        for r in daysSelectedArr {
            daysSelected += r + "."
        }
        
        
        
        //we will use appDelegate to connect to our core data
        //this is the default app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //create a context
        //a handler for us to be able to access the database
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //add user to db
      //first we need to describe our entity that we would want to enter our user to
      //let newCourse = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: context)
      
        
        var profEmail = profEmailTextField.text
        let profName = profNameTextField.text
        let courseName = courseNameTextField.text
        let courseNum = courseNumTextField.text
        let courseLocation = courseLocationTextField.text
        let schedule = daysSelected
        let timeFrom = timeFromTextField.text
        let timeTo = timeToTextField.text
        
        
        
        
        // ------------------
        
        /*    validate input of user     */
        
        // first step: start by making sure that all fields are entered, if not then show alert and return
        if (profName == "" || courseName == "" || courseNum == "" || courseLocation == "" || schedule.isEmpty || timeFrom == "" || timeTo == ""){
            
            let emptyAlert = UIAlertController(title: "Empty Fields", message: "Please enter all fields", preferredStyle: UIAlertControllerStyle.Alert)
            
            //show it
            //showViewController(simpleAlert, sender: self);
            self.presentViewController(emptyAlert, animated: true, completion: nil)
            
            //let it appear for two minutes
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                emptyAlert.dismissViewControllerAnimated(true, completion: nil)
            })
            return
        }
        
        //second step: make sure that the email is correct and in the right format, if not then show alert and return
        if !isValidEmail(profEmailTextField.text!)
        {
            let simpleAlert = UIAlertController(title: "Wrong Email", message: "Please enter a correct email address", preferredStyle: UIAlertControllerStyle.Alert)
            
            //show it
            //showViewController(simpleAlert, sender: self);
            self.presentViewController(simpleAlert, animated: true, completion: nil)
            
            //let it appear for two minutes
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                simpleAlert.dismissViewControllerAnimated(true, completion: nil)
            })
            return
        }
        
        
        
        
        //finally: if the previous two steps successed then put everything inside the database
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
            
            
            //clear the text fields
            
            /*
            courseNameTextField.text = ""
            courseNumTextField.text = ""
            courseLocationTextField.text = ""
            timeFromTextField.text = ""
            timeToTextField.text = ""
            profNameTextField.text = ""
            profEmailTextField.text = ""
            
            */
            
            
            //done saving the input to the database
            
            
            
            
            
            /***************************************************************************************/
            /*    This is just for testing purpose, retrive the data after storing it to check     */
            /***************************************************************************************/
            
            
            //retrive data
            //do that by creating a request
            let request = NSFetchRequest(entityName: "Course")
            
            //u need this to actually return the data itself and not just info about it
            request.returnsObjectsAsFaults = false
            
            do {
                //now we need a var to store data that we get back from it
                let results = try context.executeFetchRequest(request)
                
                
                if results.count > 0 {
                    print("Number ourses found")
                    print(results.count)
                    
                    //by defualt results will contain ... therefore cast it
                    for result in results as! [NSManagedObject] {
                        
                        //now we can access the info
                        print(result.valueForKey("name")!)
                        print(result.valueForKey("number")!)
                        print(result.valueForKey("location")!)
                        print(result.valueForKey("days")!)
                        print(result.valueForKey("timeFrom")!)
                        print(result.valueForKey("timeTo")!)
                        print(result.valueForKey("profName")!)
                        print(result.valueForKey("profEmail")!)
                        
                        
                        
                        
                        
                        
                        
                    }
                }
                
            }
            catch {
                print("error fetch failed ")
            }
            
            
            

            
            
        //otherwise (if there was problems saving the data) catch it and print that
            
        }
        catch {
            print("there was a problem")
            
        }

        
        // ------------------
        
        
        
    }
    
    
    
    //this function will validate email
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        
        picker.delegate = self
        picker.dataSource = self
       
        
        
        //the following will be used to display the buildings picker view with a "done" and a "cancel" buttons
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        //
        
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(addCourseViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(addCourseViewController.cancelPicker))

        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true

        
        courseLocationTextField.inputView = picker
        courseLocationTextField.inputAccessoryView = toolBar
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //these two functions will handle the done and the cancel buttons on the buildings picker
    func donePicker(){
        courseLocationTextField.resignFirstResponder()
    }
    
    func cancelPicker(){
        //courseLocationTextField.text = ""
        courseLocationTextField.resignFirstResponder()
    }


}

