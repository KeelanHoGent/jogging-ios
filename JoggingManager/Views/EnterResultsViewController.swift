//
//  EnterResultsViewController.swift
//  JoggingManager
//
//  Created by Keelan Savat on 06/08/2020.
//  Copyright © 2020 Keelan Savat. All rights reserved.
//

import UIKit

class EnterResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var startNumberTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    var race: Race!
    var runners: [Runner] = []
    var results = [Runner]()
    var submitFailed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = race.raceName
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        errorLabel.text = "ERRORLABEL"
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        
        RaceController.shared.fetchRunners(race.raceId) { (runners) in
            if let runners = runners {
                self.updateUI(runners)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SubmittedSegue" {
            let submittedViewController = segue.destination as! SubmittedViewController
            submittedViewController.error = submitFailed
        }
    }
    
    func updateUI(_ runners: [Runner]) {
        DispatchQueue.main.async {
            self.runners = runners
            self.tableView.reloadData()
        }
    }
    
    @IBAction func submitStartNumber(_ sender: Any) {
        let startNumber = Int(startNumberTextField.text!)
        let runner = runners.first(where: { $0.startNumber == startNumber})
        
        // error handling
        if startNumber == nil {
            errorLabel.text = "Dit is een ongeldig startnummer"
            errorLabel.isHidden = false
            startNumberTextField.text = ""
            return
        } else if runner == nil {
            errorLabel.text = "Er is geen loper met het startnummer \(String(startNumber!))"
            errorLabel.isHidden = false
            startNumberTextField.text = ""
            return
        } else if results.contains(where: { $0.startNumber == startNumber}) {
            errorLabel.text = "De loper met startnummer \(startNumber!) is al ingevuld"
            errorLabel.isHidden = false
            startNumberTextField.text = ""
            return
        }
        
        errorLabel.isHidden = true
        errorLabel.text = ""
        
        // a copy is made to make sure the original object stays immutable
        var newRunner = runner!.getCopy()
        newRunner.ranking = results.count + 1
        results.append(newRunner)
        startNumberTextField.text = ""
        self.tableView.reloadData()
    }
    
    @IBAction func submitResults(_ sender: Any) {
        if results.count < 1 {
            errorLabel.text = "Je kan geen lege lijst indienen"
            errorLabel.isHidden = false
            return
        }
        
        // This is needed to override possible previous finishes for this race
        for runner in runners {
            if results.first(where: { $0.startNumber == runner.startNumber}) == nil {
                var newRunner = runner.getCopy()
                newRunner.ranking = nil
                results.append(newRunner)
            }
        }
        
        let alert = UIAlertController(title: "Bevestigen Resultaten", message: "Ben je zeker dat je deze resultaten wilt indienen?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Indienen", style: .default) {
            action in self.uploadResults()
        })
        alert.addAction(UIAlertAction(title: "Annuleren", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func uploadResults() {
        RaceController.shared.submitRunners(runners: results) { (runners) in
            DispatchQueue.main.async {
                self.submitFailed = runners == nil
                self.performSegue(withIdentifier: "SubmittedSegue", sender: nil)
            }
        }
    }
    
    // Tableview methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultedRunnerIdentifier", for: indexPath) as! RunnerTableViewCell
        
        let runner = results[indexPath.row]
        cell.update(with: runner)
        
        return cell
    }
}
