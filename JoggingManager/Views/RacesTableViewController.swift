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

    override func viewDidLoad() {
        super.viewDidLoad()

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
            runnersTableViewController.raceId = races[index].raceId
        }
    }
    
    func configure(_ cell: UITableViewCell, forCellAt indexPath: IndexPath) {
        let race = races[indexPath.row]
        cell.textLabel?.text = race.raceName
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return races.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "raceCellIdentifier", for: indexPath)

        configure(cell, forCellAt: indexPath)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowRaceSegue", sender: nil)
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
