//
//  ViewController.swift
//  unipi-events
//
//  Created by Ildar Gubaydullin on 26/04/2018.
//  Copyright © 2018 Ildar Gubaydullin. All rights reserved.
//

import UIKit

class EventTableViewController:
    UITableViewController
{
    
    private let dwarves = [
        "Sleepy", "Sneezy", "Bashful"
    ]
    
    let simpleTableIdentifier = "SimpleTableIdentifier"
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    // MARK:-
    // MARK: Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dwarves.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(
                style: .subtitle,
                reuseIdentifier: simpleTableIdentifier)
            let image = UIImage(named: "rn-logo")
            cell?.imageView?.image = image
            
        }
        cell?.detailTextLabel?.text = "Hello, people"
        cell?.textLabel?.text = dwarves[indexPath.row]
        return cell!
    }

}

