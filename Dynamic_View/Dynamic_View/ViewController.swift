//
//  ViewController.swift
//  Dynamic_View
//
//  Created by Nasraddin Rustamov on 8/25/21.
//

import UIKit

class ViewController: UIViewController {
       let transparentView = UIView()
       let selectLanguageButton = UIButton()
       var selectedButton = UIButton()
       let selectedLanguageLabel = UILabel()
       let selectedImageView = UIImageView()
       let tableView = UITableView()
       var dataSource = [String]()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .white
           configureSelectionButton()
           configureTableView()
           configureSelectedItems()
       }
    func configureSelectionButton() {
        selectLanguageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectLanguageButton)
        selectLanguageButton.backgroundColor = .clear
        selectLanguageButton.layer.borderWidth = 2
        selectLanguageButton.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        selectLanguageButton.layer.cornerRadius = 10
        selectLanguageButton.setTitle("Select language", for: .normal)
        selectLanguageButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        selectLanguageButton.setTitleColor(.black, for: .normal)
        selectLanguageButton.titleEdgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 40)
        selectLanguageButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 275)
        selectLanguageButton.addTarget(self, action: #selector(onClickSelectLanguage), for: .touchUpInside)
        NSLayoutConstraint.activate([
            selectLanguageButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 70),
            selectLanguageButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            selectLanguageButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            selectLanguageButton.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor,multiplier: 0.1)
        ])
    }
    
    func configureSelectedItems() {
        selectedLanguageLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        selectedLanguageLabel.font = UIFont.boldSystemFont(ofSize: 30)
        selectedImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.addSubview(selectedLanguageLabel)
        view.addSubview(selectedImageView)
        NSLayoutConstraint.activate([
            selectedImageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -200),
            selectedImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            selectedImageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.23),
            selectedImageView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.1),
            selectedLanguageLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 20),
            selectedLanguageLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -215),
            selectedLanguageLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.55)
            
        ])
    }
    
       func addTransparentView(frames: CGRect) {
           let window = UIApplication.shared.keyWindow
           transparentView.frame = window?.frame ?? self.view.frame
           self.view.addSubview(transparentView)
           
           tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
           self.view.addSubview(tableView)
           tableView.layer.cornerRadius = 5
           
           transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
           tableView.reloadData()
           let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
           transparentView.addGestureRecognizer(tapgesture)
           transparentView.alpha = 0
           UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
               self.transparentView.alpha = 0.5
               self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
           }, completion: nil)
       }
       
       @objc func removeTransparentView() {
           let frames = selectedButton.frame
           UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
               self.transparentView.alpha = 0
               self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
           }, completion: nil)
       }

      @objc func onClickSelectLanguage() {
           dataSource = ["Swift", "C", "Java","Kotlin","Python"]
           selectedButton = selectLanguageButton
           addTransparentView(frames: selectLanguageButton.frame)
       }
      func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SelectableCell.self, forCellReuseIdentifier: "Cell")
    }
   }

   extension ViewController: UITableViewDelegate, UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return dataSource.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           cell.textLabel?.text = dataSource[indexPath.row]
           return cell
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 50
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
           selectedButton.setImage(UIImage(named: dataSource[indexPath.row]), for: .normal)
           selectedLanguageLabel.text = dataSource[indexPath.row]
           selectedImageView.image = UIImage(named: dataSource[indexPath.row])
           removeTransparentView()
       }
   }

class SelectableCell : UITableViewCell {
    
}
