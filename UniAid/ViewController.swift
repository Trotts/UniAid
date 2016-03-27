import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet var todayLabel: UILabel!
    @IBOutlet var open: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var studentCorses = [Course]()
    var directionCor = Cordinates(latitude: 0.0, longtitude: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        deleteAllData("Course")
        fatchData()
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fatchData()
    {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
  
        let request = NSFetchRequest(entityName: "Course")
        request.returnsObjectsAsFaults = false
        do
        {
            let resault : NSArray = try context.executeFetchRequest(request)
            if(resault.count > 0)
            {
                for res in resault
                {
                    studentCorses.append(Course(course: res.valueForKey("name") as! String, courseNum: res.valueForKey("number") as! String, prof: res.valueForKey("profName") as! String, profEmail: res.valueForKey("profEmail") as! String, buildingName: res.valueForKey("location") as! String, scheduale: ["w","f"]))
                    
                }
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

    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(studentCorses.count == 0)
        {
            todayLabel.text="No courses for today!"
        }
        return studentCorses.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CourceCell
        
        var courseName = studentCorses[indexPath.row].Course
        let courseNum = String(studentCorses[indexPath.row].CourseNumber)
        courseName.appendContentsOf(" ")
        courseName.appendContentsOf(courseNum)
        cell.courseName.text = courseName
        cell.layer.borderWidth = 2.0
        cell.layer.cornerRadius = 12
        cell.layer.borderColor = UIColor.clearColor().CGColor
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let directions = UITableViewRowAction(style: .Normal, title: "Directions") { (action: UITableViewRowAction!, indexpath:NSIndexPath!) -> Void in
            
            let building = self.studentCorses[indexPath.row].BuildingName
            
            NSUserDefaults.standardUserDefaults().setValue(building, forKey: "buildingName")
            
            self.performSegueWithIdentifier("map", sender: self)
            
        }
        directions.backgroundColor = UIColor.orangeColor()
        return [directions]
    }
    
}