import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet var todayLabel: UILabel!
    @IBOutlet var open: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var animation: UIImageView!
    var studentCorses = [Course]()
    var todayCourses = [Course]()
    var directionCor = Cordinates(latitude: 0.0, longtitude: 0.0)
    var dayToday = ""
    var intDay = 0
    var myImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intDay = getDayOfWeek()!
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "fromMain")
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
    
    // Gets the current day as int
    func getDayOfWeek()->Int? {
        let todayDate = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let myComponents = myCalendar?.components(NSCalendarUnit.Weekday, fromDate: todayDate)
        let weekDay = myComponents?.weekday
        return weekDay
    }
    // Translate the int to a string
    func getTodayDayString(day: Int) -> String
    {
        switch day{
        case 2: return "Monday"
        case 3: return "Tuesday"
        case 4: return "Wednesday"
        case 5: return "Thursday"
        case 6: return "Friday"
        default: return "none"
        }
    }
    // Fetch course data for the current day in the database
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
                    studentCorses.append(Course(course: res.valueForKey("name") as! String, courseNum: res.valueForKey("number") as! String, prof: res.valueForKey("profName") as! String, profEmail: res.valueForKey("profEmail") as! String, buildingName: res.valueForKey("location") as! String, scheduale: res.valueForKey("days") as! String))
                }
            }
            else
            {
                print("Error populating")
            }
        }
        catch {
            print("Error fetch failed ")
        }
        
    }
    // Deletes all data in an entry
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
    
    
    // Populates the table with the courses for today
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(studentCorses.count == 0 || intDay < 2 || intDay > 6)
        {
            animation.layer.cornerRadius = 12
            self.animation.layer.masksToBounds = true
            todayLabel.text="No courses for today!"
            let imageData = NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("student_happy_with_te_a_ha", withExtension: "gif")!)
            let imageGif = UIImage.gifWithData(imageData!)
            let imageView = UIImageView(image: imageGif)
            imageView.frame = CGRect(x: 0.0, y: 0.0, width: 414.0, height: 402.0)
            animation.addSubview(imageView)
        }
        var tempIndex = 0
        var dayToday = getTodayDayString(intDay) as! String

        for (var i = 0; i<studentCorses.count; i++)
        {
            let sched = studentCorses[i].scheduale
            var fullsched = [String]()
            if(sched.containsString("."))
            {
                fullsched = sched.componentsSeparatedByString(".")
                
            }
            else
            {
                fullsched.append(sched)
            }
            for(var k=0; k < fullsched.count ; k += 1)
            {
                if(dayToday == fullsched[k])
                {
                    tempIndex += 1
                    todayCourses.append(studentCorses[i])
                }
            }
        }
        return tempIndex
    }
    
    // Returns the cells for the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CourceCell
        
            var courseName = todayCourses[indexPath.row].Course
            let courseNum = String(todayCourses[indexPath.row].CourseNumber)
            courseName.appendContentsOf(" ")
            courseName.appendContentsOf(courseNum)
            cell.courseName.text = courseName
            cell.layer.borderWidth = 2.0
            cell.layer.cornerRadius = 12
            cell.layer.borderColor = UIColor.clearColor().CGColor
        return cell
    }
    
    // Set the course details to user defaults for moving between Views
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        NSUserDefaults.standardUserDefaults().setValue(studentCorses[indexPath.row].BuildingName, forKey: "location")
        NSUserDefaults.standardUserDefaults().setValue(studentCorses[indexPath.row].Course, forKey: "name")
        NSUserDefaults.standardUserDefaults().setValue(studentCorses[indexPath.row].CourseNumber, forKey: "number")
        NSUserDefaults.standardUserDefaults().setValue(studentCorses[indexPath.row].Prof, forKey: "profName")
        NSUserDefaults.standardUserDefaults().setValue(studentCorses[indexPath.row].ProfEmail, forKey: "profEmail")
        NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "fromMain")

    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    // Handles the slider for Directions
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let directions = UITableViewRowAction(style: .Normal, title: "Directions") { (action: UITableViewRowAction!, indexpath:NSIndexPath!) -> Void in
            
            let building = self.studentCorses[indexPath.row].BuildingName
            
            NSUserDefaults.standardUserDefaults().setValue(building, forKey: "building")
            
            self.performSegueWithIdentifier("map", sender: self)
            
        }
        directions.backgroundColor = UIColor.orangeColor()
        return [directions]
    }
    
}