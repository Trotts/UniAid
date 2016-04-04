//
//  addAssignViewController.swift
//  Project-UniAid
//
//  Created by Amr Zokari on 2016-03-20.
//  Image picker by Cameron Trotter on 2016-03-30.
//  Copyright © 2016 Amr Zokari. All rights reserved.
//

import UIKit
import CoreData

class addAssignViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
   
    @IBOutlet var assignment: UIButton!
    @IBOutlet weak var assignNameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    
    //Functions for Image Picker
    
    // Only allow user to select Photo Library photos, attempting to use a Camera in the simulator causes a crash so has been omitted.
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard if text field selected
        assignNameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        // Notify VC of an image being picked and present
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user cancels
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, use original
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // Display the selected image.
        photoImageView.image = selectedImage
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Functions for Date Picker
    @IBAction func dueDateTextField(sender: UITextField) {
        // Create the toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        // Create buttons for toolbar
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePickerTime")
        doneButton.setTitleTextAttributes([NSFontAttributeName : UIFont.boldSystemFontOfSize(20.0),NSForegroundColorAttributeName : UIColor.orangeColor(),NSBackgroundColorAttributeName:UIColor.blackColor()],
                                           forState: UIControlState.Normal)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPickerTime")
        cancelButton.setTitleTextAttributes([NSFontAttributeName : UIFont.boldSystemFontOfSize(20.0),NSForegroundColorAttributeName : UIColor.orangeColor(),NSBackgroundColorAttributeName:UIColor.blackColor()],
                                    forState: UIControlState.Normal)
        // Set the toolbar
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        // Create date picker
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        sender.inputView = datePickerView
        sender.inputAccessoryView = toolBar
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    //Function for Time
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        dueDateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    // If Done Clicked
    func donePickerTime(){
        dueDateTextField.resignFirstResponder()
    }
    // If Cancel clicked
    func cancelPickerTime(){
        dueDateTextField.text = ""
        dueDateTextField.resignFirstResponder()
    }
    
    // Functions to assign Course
    var emptylist = ["No Courses, please add some"]
    var picker = UIPickerView()
    var returnCourses = [String]()
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Returns the # of rows in each component
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

    
    //Function to handle keyboard disappearing
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    
    // Functions for Add Button
    @IBAction func addAssignButton(sender: AnyObject) {
        
        // Use appDelegate to connect to our core data
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //create a context (a handler for us to be able to access the database)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        // Add assignment to Database
        let newAssign = NSEntityDescription.insertNewObjectForEntityForName("Assignment", inManagedObjectContext: context)
        
        newAssign.setValue(assignNameTextField.text, forKey: "name")
        newAssign.setValue(dueDateTextField.text, forKey: "dueDate")
        newAssign.setValue(courseNameTextField.text, forKey: "course")
        // Save to the Database
        do {
            try context.save()
            // If done:
            let simpleAlert = UIAlertController(title: "Success", message: "Assignment was added", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(simpleAlert, animated: true, completion: nil)
            // Let it appear for two minutes
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                simpleAlert.dismissViewControllerAnimated(true, completion: nil)
            })
            // Reset the fields
            assignNameTextField.text = ""
            dueDateTextField.text = ""
            courseNameTextField.text = ""
            photoImageView.image = UIImage(named: "defaultPhoto")
        }
        catch {
            print("there was a problem")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignment.layer.cornerRadius = 12
        getCourses()
        picker.delegate = self
        picker.dataSource = self
        
        // The following will be used to display the courses picker view with a "done" and a "cancel" buttons
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
    
    // Gets list of Courses currently saved.
    func getCourses() {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // Create a context (a handler for us to be able to access the database)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        // Retrive data
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

    // Handles Done button on course picker
    func donePicker(){
        courseNameTextField.resignFirstResponder()
    }
    // Handles Cancel button on course picker
    func cancelPicker(){
        courseNameTextField.text = ""
        courseNameTextField.resignFirstResponder()
    }


    
    
}
