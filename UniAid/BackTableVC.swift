//
//  BackTableVC.swift
//  UniAid
//
//  Created by igor epshtein on 2016-03-14.
//  Copyright © 2016 igor epshtein. All rights reserved.
//

// Handles the population of the NavBar
import Foundation

class BackTableVC: UITableViewController {
    var TableArray = [String]()
    override func viewDidLoad() {
        // Identifiers of the Cells
        TableArray = ["Home","Notes", "Courses"]
    }
    // Return number of cells to populate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    // Populate the cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = TableArray[indexPath.row]
            return cell
        }
}