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
    
    
    //textfields
    @IBOutlet weak var courseNameTextField: UITextField!
    
    @IBOutlet weak var courseNumTextField: UITextField! 
   
    @IBOutlet weak var courseLocationTextField: UITextField!

    @IBOutlet weak var profNameTextField: UITextField!
    
    @IBOutlet weak var profEmailTextField: UITextField!
    
    
    //switche
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
        
        //for testing purpose
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
        
        //for testing purpose
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
        
        //for testing purpose
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
        
        //for testing purpose
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
        
        //for testing purpose
        print("Array:")
        print(daysSelectedArr)
    }
    
    //This function will be used to reset the switches after a user's input is done
    @IBAction func resetClicked() {
        mondaySwitch.setOn(false, animated: true);
        tuesdaySwitch.setOn(false, animated: true);
        wednesdaySwitch.setOn(false, animated: true);
        thursdaySwitch.setOn(false, animated: true);
        fridaySwitch.setOn(false, animated: true);
    }
  
 
  
    //use this to keep the days of the course
    var daysSelectedArr = [String]()
    
    var buildings = ["Dentistry Building","Goldberg Computer Science Building","Howe Hall","Boulden Building","Burbidge Building","Chase Building","Chemical Engineering","Chemistry","Kenneth C. Rowe Management Building","Killam Library","Life Sciences Centre","Marion McCain Arts and Social Sciences","Mona Campbell Building","Dalhousie Arts Centre","Dalplex","Sir James Dunn Building","Student Union Building","Weldon Law Building","Tupper Building"]
   
    
    //picker for the location
    var picker = UIPickerView()
    
    
    
    
    //Time of classes code starts here
    
    /*********************************************************************/
    // pickers for time
    /*********************************************************************/
    
    
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
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePickerTimeFor")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPickerTimeFor")
        
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true

        
        //handle the time
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        sender.inputAccessoryView = toolBar

        datePickerView.addTarget(self, action: Selector("handleFromTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
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
    
    
    
    //
    //functions to handle time - to
    @IBAction func timeToTextField(sender: UITextField) {
       
        
        //done and cancel button
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
   
        
        //handle the time
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        sender.inputAccessoryView = toolBar

        datePickerView.addTarget(self, action: Selector("handleToTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
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
    
    
    
    
    
    /*******************************************************************************/
    //functions to handle the page sliding up/down when time picker appear/disappear
     /*******************************************************************************/
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == profNameTextField || textField == profEmailTextField) {
            animateViewMoving(true, moveValue: 130)
        }
        
        if (textField == timeToTextField){
            animateViewMoving(true, moveValue: 30)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField == profNameTextField || textField == profEmailTextField) {
            animateViewMoving(false, moveValue: 130)
        }
        
        if (textField == timeToTextField){
            animateViewMoving(false, moveValue: 30)
        }
    }


    func animateViewMoving (up:Bool, moveValue :CGFloat){
        
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
    
    
    /***************************************************************/
   
    
    //function to handle keyboard disappearing
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    
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
    @IBAction func saveButton(sender: AnyObject) {
        
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
      
        let request = NSFetchRequest(entityName: "Course")

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
            print("error1")
          }

            try context.save()
            
            //inform the user that it has been saved successfully
            let simpleAlert = UIAlertController(title: "Success", message: "Course was Saved", preferredStyle: UIAlertControllerStyle.Alert)
            
            //show it
            //showViewController(simpleAlert, sender: self);
            self.presentViewController(simpleAlert, animated: true, completion: nil)
            
            //let it appear for two minutes
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                simpleAlert.dismissViewControllerAnimated(true, completion: nil)
            })

            
            //done saving the input to the database
            /***************************************************************************************/
        }
        catch {
            print("there was a problem")
            
        }
        
  }
        
        //finally: if the previous two steps successed then put everything inside the database
  
            //done saving the input to the database
            /***************************************************************************************/

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
      
      showInfo()
      
        
        picker.delegate = self
        picker.dataSource = self
       
        //the following will be used to display the buildings picker view with a "done" and a "cancel" buttons
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
    
    
    //these two functions will handle the done and the cancel buttons on the buildings picker
    func donePicker(){
        courseLocationTextField.resignFirstResponder()
    }
    
    func cancelPicker(){
        courseLocationTextField.text = ""
        courseLocationTextField.resignFirstResponder()
    }

  /*
   * Display the course data in the text Field to be edited
   */
  func showInfo() {
    
    //we will use appDelegate to connect to our core data
    //this is the default app delegate
    let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //create a context
    //a handler for us to be able to access the database
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
        print("error1")
      }
    }
    catch {
      print("error fetch failed ")
    }
  }

}