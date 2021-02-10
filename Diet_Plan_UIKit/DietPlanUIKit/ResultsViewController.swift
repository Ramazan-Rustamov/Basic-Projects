//
//  ResultsViewController.swift
//  DietPlanUIKit
//
//  Created by Nasraddin Rustamov on 1/19/21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var carbohydratesValue = 0
    var proteinValue = 0
    var fatValue = 0
    
    @IBOutlet weak var carbohydratesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carbohydratesLabel.text = "\(carbohydratesValue)g"
        proteinLabel.text = "\(proteinValue)g"
        fatLabel.text = "\(fatValue)g"
        
    }
    

    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
