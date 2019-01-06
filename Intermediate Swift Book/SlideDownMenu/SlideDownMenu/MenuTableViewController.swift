//
//  MenuTableViewController.swift
//  SlideDownMenu
//
//  Created by Simon Ng on 27/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var menuItems = ["Home", "News", "Tech", "Finance", "Reviews"]
    var currentItem = "Home"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuTableViewCell

        // Configure the cell...
        cell.titleLabel.text = menuItems[indexPath.row]
        cell.titleLabel.textColor = (menuItems[indexPath.row] == currentItem) ? UIColor.white : UIColor.gray

        return cell
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let menuTableViewController = segue.source as! MenuTableViewController
        if let selectedIndexPath = menuTableViewController.tableView.indexPathForSelectedRow {
            currentItem = menuItems[selectedIndexPath.row]
        }
    }
}
