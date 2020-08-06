//
//  RunnersTableViewController.swift
//  JoggingManager
//
//  Created by Keelan Savat on 06/08/2020.
//  Copyright © 2020 Keelan Savat. All rights reserved.
//

import UIKit

class RunnersTableViewController: UITableViewController {
    
    var raceId: Int!
    var runners = [Runner]()

    override func viewDidLoad() {
        super.viewDidLoad()

        RaceController.shared.fetchRunners(raceId) { (runners) in
            if let runners = runners {
                self.updateUI(runners)
            }
        }
    }

    func updateUI(_ runners: [Runner]) {
        DispatchQueue.main.async {
            self.runners = runners
            self.tableView.reloadData()
        }
    }
    
    func configure(_ cell: UITableViewCell, forCellAt indexPath: IndexPath) {
        let runner = runners[indexPath.row]
        cell.textLabel?.text = runner.name
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "runnerCellIdentifier", for: indexPath)

        configure(cell, forCellAt: indexPath)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
