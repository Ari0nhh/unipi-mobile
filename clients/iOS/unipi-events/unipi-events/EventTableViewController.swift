//
//  EventTableViewController.swift
//  unipi-events
//
//  Created by Ildar Gubaydullin on 26/04/2018.
//  Copyright © 2018 Ildar Gubaydullin. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController
{
    
    let cellTableIdentifier = "CellTableIdentifier"
    let computers = [
        ["Name": "Macbook Air", "Color": "Silver"],
        ["Name": "Macbook Pro", "Color": "Gray"],
        ["Name": "Lenovo", "Color": "Purple"],
        ["Name": "Macbook Air", "Color": "Silver"],
        ["Name": "Macbook Pro", "Color": "Gray"],
        ["Name": "Lenovo", "Color": "Purple"],
        ["Name": "Macbook Air", "Color": "Silver"],
        ["Name": "Macbook Pro", "Color": "Gray"],
        ["Name": "Lenovo", "Color": "Purple"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: cellTableIdentifier)
        tableView.self.rowHeight = 66
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    // MARK:-
    // MARK: Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return computers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTableIdentifier, for: indexPath)
            as! EventTableViewCell
        
        // let rowData = computers[indexPath.row]
        cell.caption = "Название события" //rowData["Name"]!
        cell.subCaption = "Организация или место проведения" //rowData["Color"]!
        
        return cell
    }

}

