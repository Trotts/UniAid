import UIKit

class ViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet var open: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var studentCorses = [Course(course: "CSCI", courseNum: 4414, prof: "Nauzer", profEmail: "profEmail: aaa@gmail.com", buildingName: "Howe", scheduale: ["s","w","f"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        
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
        
        return cell
        
    }
    //xcz
}