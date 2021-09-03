//
//  ViewController.swift
//  StackViewPractice
//
//  Created by Nasraddin Rustamov on 9/1/21.
//

import UIKit

class ViewController: UIViewController {
    
    var footballClubs = Bundle.main.decode([FootballClubs].self, from: "FootballClubs.json")
    let mainStackView = UIStackView()
    let clubLogosStackView = UIStackView()
    let matchdayStackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureStackView()
    }
    
    func configureStackView() {
        view.addSubview(mainStackView)
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 40
        
        for index in 0...footballClubs.count-1 {
            let button = UIButton()
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .red
                button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                button.layer.cornerRadius = 10
            button.addAction(for: .touchUpInside){
            }
            button.setTitle("\(footballClubs[index].day ?? "N/A")" , for: .normal)
            
            let firstClub = UIImageView(image: UIImage(named: footballClubs[index].clubs![0]))
            let secondClub = UIImageView(image: UIImage(named: footballClubs[index].clubs![1]))
            let matchDetails = UILabel()
            matchDetails.text = footballClubs[index].details
            matchDetails.textColor = .white
            matchDetails.font = UIFont.boldSystemFont(ofSize: 20)
            mainStackView.addArrangedSubview(button)
            mainStackView.addArrangedSubview(firstClub)
            mainStackView.addArrangedSubview(secondClub)
            mainStackView.addArrangedSubview(matchDetails)

        }
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)

        ])
    }

}
extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}
