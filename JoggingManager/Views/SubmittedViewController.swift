//
//  SubmittedViewController.swift
//  JoggingManager
//
//  Created by Keelan Savat on 26/08/2020.
//  Copyright © 2020 Keelan Savat. All rights reserved.
//

import UIKit

class SubmittedViewController: UIViewController {

    @IBOutlet var actionButton: UIButton!
    @IBOutlet var retryButton: UIButton!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var failedImage: UIImageView!
    @IBOutlet var checkImage: UIImageView!
    
    var error: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.layer.cornerRadius = 5
        
        retryButton.setTitle("Opnieuw proberen", for: .normal)

        if error {
            messageLabel.text = "Er is iets misgegaan bij het opslaan van de resultaten."
            actionButton.setTitle("Opnieuw proberen", for: .normal)
        } else {
            messageLabel.text = "De resultaten zijn succesvol opgeslaan!"
            actionButton.setTitle("Terug naar menu", for: .normal)
        }
        
        checkImage.isHidden = error
        failedImage.isHidden = !error
        retryButton.isHidden = !error
    }

    @IBAction func retrySubmit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
