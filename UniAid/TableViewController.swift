//
//  ViewController.swift
//  NotesTest
//
//  Created by Cameron Trotter on 24/03/2016.
//  Copyright © 2016 Cameron Trotter. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NoteViewDelegate {
    
    @IBOutlet var open: UIBarButtonItem!
    
    //  Keys = "title", "body"
    var arrNotes = [[String:String]]()
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        if let newNotes = NSUserDefaults.standardUserDefaults().arrayForKey("notes") as? [[String:String]] {
            arrNotes = newNotes
        }
        open.target = self.revealViewController()
        open.action = #selector(SWRevealViewController.revealToggle(_:))
        self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return arrNotes.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
                as UITableViewCell
            cell.textLabel!.text = arrNotes[indexPath.row]["title"]
            return cell
    }
    override func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
            self.selectedIndex = indexPath.row
            performSegueWithIdentifier("showEditorSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:
        AnyObject?) {
            let notesEditorVC = segue.destinationViewController as!
            NotesViewController
            notesEditorVC.navigationItem.title =
                arrNotes[self.selectedIndex]["title"]
            notesEditorVC.strBodyText =
                arrNotes[self.selectedIndex]["body"]
            notesEditorVC.delegate = self
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            arrNotes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

    @IBAction func newNote() {
        let newDict = ["title" : "",
            "body" : ""]
        arrNotes.insert(newDict, atIndex: 0)
        self.selectedIndex = 0
        self.tableView.reloadData()
        saveNotesArray()
        performSegueWithIdentifier("showEditorSegue", sender: nil)
    }
    
    func didUpdateNoteWithTitle(newTitle: String, andBody newBody:
        String) {
            self.arrNotes[self.selectedIndex]["title"] = newTitle
            self.arrNotes[self.selectedIndex]["body"] = newBody
            self.tableView.reloadData()
            saveNotesArray()
    }
    
    func saveNotesArray() {
        NSUserDefaults.standardUserDefaults().setObject(arrNotes,
            forKey: "notes")
        NSUserDefaults.standardUserDefaults().synchronize()
    }    
}

