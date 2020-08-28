//
//  MenuViewController.swift
//  JoggingManager
//
//  Created by Keelan Savat on 06/08/2020.
//  Copyright © 2020 Keelan Savat. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RacesSegue" {
            let racesTableViewController = segue.destination as! RacesTableViewController
            racesTableViewController.isEnterResults = false
        } else if segue.identifier == "RacesResultsSegue" {
            let racesTableViewController = segue.destination as! RacesTableViewController
            racesTableViewController.isEnterResults = true
        }
    }

    @IBAction func unwindToMainMenu (segue: UIStoryboardSegue) {
        
    }
}
