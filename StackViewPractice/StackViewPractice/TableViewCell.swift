//
//  TableViewCell.swift
//  StackViewPractice
//
//  Created by Nasraddin Rustamov on 9/11/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    var footballClubs = Bundle.main.decode([FootballClubs].self, from: "FootballClubs.json")
    let mainStackView = UIStackView()
    let clubLogosStackView = UIStackView()
    let matchdayStackView = UIStackView()
    let homeClub = UIImageView()
    let awayClub = UIImageView()
    let button = UIButton()
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureStackView() {
        addSubview(mainStackView)
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 20
        mainStackView.addArrangedSubview(clubLogosStackView)
        mainStackView.addArrangedSubview(matchdayStackView)
        
        clubLogosStackView.axis = .horizontal
        clubLogosStackView.distribution = .fillEqually
        clubLogosStackView.spacing = 20
        clubLogosStackView.addArrangedSubview(homeClub)
        clubLogosStackView.addArrangedSubview(awayClub)
        
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        matchdayStackView.axis = .vertical
        matchdayStackView.distribution = .fillEqually
        matchdayStackView.spacing = 20
        matchdayStackView.addArrangedSubview(button)
        matchdayStackView.addArrangedSubview(label)

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)

        ])
    }
    func setImages(image1 : String, image2: String){
        homeClub.image = UIImage(named: image1)
        awayClub.image = UIImage(named: image2)
    }
    func setTitles(buttonTitle: String, labelTitle: String){
        button.setTitle(buttonTitle, for: .normal)
        label.text = labelTitle
    }
    
}

