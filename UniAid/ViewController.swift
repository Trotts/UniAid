import UIKit

class ViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet var open: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var studentCorses = [Course(course: "CSCI", courseNum: 4414, prof: "Nauzer", profEmail: "profEmail: aaa@gmail.com", buildingName: "Howe", scheduale: ["s","w","f"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentCorses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CourceCell
        
        var courseName = studentCorses[indexPath.row].Course
        let courseNum = String(studentCorses[indexPath.row].CourseNumber)
        print(courseNum)
        courseName += " "
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
            
            self.performSegueWithIdentifier("map", sender: self)
            
        }
        directions.backgroundColor = UIColor.orangeColor()
        return [directions]
    }
    
}