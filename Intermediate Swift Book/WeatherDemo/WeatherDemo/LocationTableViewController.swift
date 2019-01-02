//
//  LocationTableViewController.swift
//  WeatherDemo
//
//  Created by Simon Ng on 14/1/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {
    let locations = ["Paris, France", "Kyoto, Japan", "Sydney, Australia", "Seattle, U.S.", "New York, U.S.", "Hong Kong, Hong Kong", "Taipei, Taiwan", "London, U.K.", "Vancouver, Canada"]
    var selectedLocation = "Paris, France"
    
    var defaults = NSUserDefaults(suiteName: "group.com.appcoda.weatherdemo")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return locations.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        // Configure the cell...
        cell.textLabel?.text = locations[indexPath.row]
        cell.accessoryType = (locations[indexPath.row] == selectedLocation) ? .Checkmark : .None
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        if let location = cell?.textLabel?.text {
            selectedLocation = location
            defaults.setValue(selectedLocation, forKey: "location")
        }
        
        tableView.reloadData()
    }

}
