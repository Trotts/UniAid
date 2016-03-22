//
//  ViewController.swift
//  Project-UniAid
//
//  Created by Amr Zokari on 2016-03-13.
//  Copyright © 2016 Amr Zokari. All rights reserved.
//

import UIKit
import CoreData


class courseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    
    
    
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
    
    
    
    
    //var daysOfWeekSelected = ""
    
    var daysSelectedArr = [String]()
    
    var buildings = ["CS", "Henry Hicks", "Management", "Life Science"]
   
    
    
    var picker = UIPickerView()
    
    
    
    
    /*******************************************************/
    //new picker for time
    
    
    
    //Time of classes code starts here
    
    @IBOutlet weak var timeFromTextField: UITextField!
    
    @IBOutlet weak var timeToTextField: UITextField!
    
    //functions to handle time - from
    @IBAction func timeFromTextField(sender: UITextField) {
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("handleFromTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func handleFromTimePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        timeFromTextField.text = timeFormatter.stringFromDate(sender.date)
    }
    
    //functions to handle time - to
    @IBAction func timeToTextField(sender: UITextField) {
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("handleToTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    
    func handleToTimePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        timeToTextField.text = timeFormatter.stringFromDate(sender.date)
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
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return buildings[row]
    }
    
    
    
    //Add a cousre action
    @IBAction func addCourseButton(sender: AnyObject) {
        
        
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
        var newCourse = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: context)
        
        newCourse.setValue(courseNameTextField.text, forKey: "name")
        newCourse.setValue(courseNumTextField.text, forKey: "number")
     //   newCourse.setValue(courseScheduleTextField.text, forKey: "schedule")
        newCourse.setValue(courseLocationTextField.text, forKey: "location")
        newCourse.setValue(daysSelected, forKey: "days")
        newCourse.setValue(timeFromTextField.text, forKey: "timeFrom")
        newCourse.setValue(timeToTextField.text, forKey: "timeTo")
        newCourse.setValue(profNameTextField.text, forKey: "profName")
        newCourse.setValue(profEmailTextField.text, forKey: "profEmail")
        
        //now save it to the db
        //we do that be calling the context
        
        
        do {
            try context.save()
            var alert = UIAlertController(title: "Course Added", message: "Course was added Successfully", preferredStyle: UIAlertControllerStyle.Alert)
            
            let confirmAdd = UIAlertAction(title: "Great", style: UIAlertActionStyle.Cancel , handler: nil)
            
            
            alert.addAction(confirmAdd)
            

            showViewController(alert, sender: self)
            
            //clear text fields
            courseNameTextField.text = ""
            courseNumTextField.text = ""
            courseLocationTextField.text = ""
            timeFromTextField.text = ""
            timeToTextField.text = ""
            profNameTextField.text = ""
            profEmailTextField.text = ""
            
            
            
        }
        catch {
            print("there was a problem")
        }
        
        
        
        
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
        

        
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        picker.delegate = self
        picker.dataSource = self
      
        
        
        courseLocationTextField.inputView = picker
      
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

