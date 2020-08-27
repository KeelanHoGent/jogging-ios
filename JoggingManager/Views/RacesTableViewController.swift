//
//  RacesTableViewController.swift
//  JoggingManager
//
//  Created by Keelan Savat on 06/08/2020.
//  Copyright © 2020 Keelan Savat. All rights reserved.
//

import UIKit

class RacesTableViewController: UITableViewController {
    
    var races = [Race]()
    var isEnterResults = Bool()

    override func viewDidLoad() {
        super.viewDidLoad()

        if !isEnterResults {
            title = "Races"
            tableView.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.7098039216, blue: 0.9137254902, alpha: 1)
            
        } else {
            title = "Resultaten Invullen"
        }
        
        RaceController.shared.fetchRaces { (races) in
            if let races = races {
                DispatchQueue.main.async {
                    self.races = races
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRaceSegue" {
            let runnersTableViewController = segue.destination as! RunnersTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            runnersTableViewController.race = races[index]
        } else if segue.identifier == "EnterResultSegue" {
            let enterResultsViewController = segue.destination as! EnterResultsViewController
            let index = tableView.indexPathForSelectedRow!.row
            enterResultsViewController.race = races[index]
        }
    }
    
    func configure(_ cell: UITableViewCell, forCellAt indexPath: IndexPath) {
        let race = races[indexPath.row]
        cell.textLabel?.text = race.raceName
        if !isEnterResults {
            cell.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.7098039216, blue: 0.9137254902, alpha: 1)
        }
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return races.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "raceCellIdentifier", for: indexPath)

        configure(cell, forCellAt: indexPath)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isEnterResults {
            performSegue(withIdentifier: "ShowRaceSegue", sender: nil)
        } else {
            performSegue(withIdentifier: "EnterResultSegue", sender: nil)
        }
        
    }

}
