//
//  ViewController.swift
//  DietPlanUIKit
//
//  Created by Nasraddin Rustamov on 1/19/21.
//

import UIKit

class CalculationViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let height = String (format: "%.f", sender.value)
        heightLabel.text = "\(height)cm"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let weight = String (format: "%.f", sender.value)
        weightLabel.text = "\(weight)kg"
        
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        let weight = weightSlider.value
        
        let carbohydrates = weight * 3
        let protein = weight * 2.5
        let fat = weight / 2
        
        if segue.destination is ResultsViewController {
            let destinatationVC = segue.destination as! ResultsViewController
            destinatationVC.carbohydratesValue = Int (carbohydrates)
            destinatationVC.proteinValue = Int (protein)
            destinatationVC.fatValue = Int (fat)
        }
    }
    
}

