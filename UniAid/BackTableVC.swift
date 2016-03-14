//
//  BackTableVC.swift
//  UniAid
//
//  Created by igor epshtein on 2016-03-14.
//  Copyright © 2016 igor epshtein. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController {
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Home","Notes","Record"]
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = TableArray[indexPath.row]
            return cell
        }
    
}