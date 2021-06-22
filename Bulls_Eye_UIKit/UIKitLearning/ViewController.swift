//
//  ViewController.swift
//  UIKitLearning
//
//  Created by Nasraddin Rustamov on 1/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var round: UILabel!
    
    var currentValue = 50
    var targetValue = 0
    var result = 0
    var stage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
    }
    
    @IBAction func showAlert() {
        // Abs method allows us to get the positive value, despite the fact , that deduction operation may be negative value
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        
        // This is to sum up all the results of our game
        result += points
        
        let message = "You scored \(points) points"
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
        }
        else if difference < 5 {
            title = "You almost had it!"
        }
        else if difference < 10 {
            title = "Not bad"
        }
        else {
            title = "Not even close"
        }
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            // It's very important to give the handler some function , as nothing will happen with nil value
            handler:{ _ in
                self.startNewRound()
            })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func startOver(_ sender: Any) {
        startNewGame()
    }
    // lroundf method allows us to convert floating value to the nearest integer value
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    func startNewRound () {
        // We make stage +=1 , as in startNewGame func we give the stage variable 0 value , no game starts at 0 round
        stage += 1
        // Int.random method allows us to give a specific range of numbers and Xcode randomly chooses one of them
        targetValue = Int.random(in: 1...100)
        // Current Value represents the value on the slider at the beginning of each round
        currentValue = 50
        slider.value = Float (currentValue)
        updateLabels()
    }
    
    func updateLabels () {
        targetLabel.text = "\(targetValue)"
        score.text = "\(result)"
        round.text = "\(stage)"
    }
    func startNewGame() {
        result = 0
        stage = 0
        startNewRound()
    }
}


