//
//  RunnerTableViewCell.swift
//  JoggingManager
//
//  Created by Keelan Savat on 07/08/2020.
//  Copyright © 2020 Keelan Savat. All rights reserved.
//

import UIKit

class RunnerTableViewCell: UITableViewCell {
    
    @IBOutlet var finishTextLabel: UILabel!
    @IBOutlet var detailsStackView: UIStackView!
    @IBOutlet var startNumberTextLabel: UILabel!
    @IBOutlet var nameTextLabel: UILabel!
    
    func update(with runner: Runner) {
        if let ranking = runner.ranking {
            finishTextLabel.text = String(ranking) + "."
            detailsStackView.alignment = .trailing
        } else {
            detailsStackView.alignment = .leading
            finishTextLabel.text = nil
        }
        startNumberTextLabel.text = "#" + String(runner.startNumber)
        nameTextLabel.text = runner.name
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
