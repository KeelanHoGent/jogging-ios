//
//  RunnersTableViewController.swift
//  JoggingManager
//
//  Created by Keelan Savat on 06/08/2020.
//  Copyright © 2020 Keelan Savat. All rights reserved.
//

import UIKit

class RunnersTableViewController: UITableViewController {
    
    var race: Race!
    var runners = [Runner]()
    var loader = LoaderMethods.getStandardLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = race.raceName
        tableView.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.7098039216, blue: 0.9137254902, alpha: 1)
        
        LoaderMethods.startLoading(view, loader: loader)
        
        RaceController.shared.fetchRunners(race.raceId) { (runners) in
            if let runners = runners {
                self.updateUI(runners)
            }
        }
    }

    func updateUI(_ runners: [Runner]) {
        DispatchQueue.main.async {
            self.runners = runners
            self.sortRunners()
            self.tableView.reloadData()
            LoaderMethods.stopLoading(self.loader)
        }
    }
    
    func startLoading() {
        
    }
    
    func sortRunners() {
        self.runners.sort {
            if let lhs = $0.ranking,
                let rhs = $1.ranking {
                return lhs < rhs
            } else if $0.ranking == nil, $1.ranking != nil {
                return false
            } else if $0.ranking != nil, $1.ranking == nil {
                return true
            } else {
                return $0.startNumber < $1.startNumber
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return runners.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "runnerCellIdentifier", for: indexPath) as! RunnerTableViewCell

        let runner = runners[indexPath.row]
        cell.update(with: runner)
        cell.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.7098039216, blue: 0.9137254902, alpha: 1)

        return cell
    }

}
