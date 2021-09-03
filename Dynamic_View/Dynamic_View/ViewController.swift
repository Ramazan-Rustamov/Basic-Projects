//
//  ViewController.swift
//  Dynamic_View
//
//  Created by BR on 30.08.21.
//

import UIKit

class ViewController: UIViewController {
    var languages : [Languages] = Bundle.main.decode([Languages].self, from: "ProgrammingLanguages.json")
    let transparentView = UIView()
    let selectLanguageButton = UIButton()
    let selectedLanguageLabel = UILabel()
    let selectedImageView = UIImageView()
    let languageDetails = UITextView()
    let tableView = UITableView()
    var collectionViewDataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSelectionButton()
        configureTableView()
        configureCollectionView()
        //configureSelectedItems()
    }
 func configureSelectionButton() {
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
     selectLanguageButton.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.layoutMarginsGuide.leadingAnchor, trailing: view.layoutMarginsGuide.trailingAnchor, bottom: nil, padding: .init(top: 50, left: 0, bottom: 0, right: 0))
    selectLanguageButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
 }
 
 func configureSelectedItems() {
     selectedLanguageLabel.font = UIFont.boldSystemFont(ofSize: 25)
     languageDetails.font = UIFont.systemFont(ofSize: 25)
     view.addSubview(selectedLanguageLabel)
     view.addSubview(selectedImageView)
     view.addSubview(languageDetails)
     selectedImageView.anchor(top: selectLanguageButton.bottomAnchor, leading: view.leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 100, left: 80, bottom: 0, right: 0), size: .init(width: 100, height: 100))
     selectedLanguageLabel.anchor(top: selectLanguageButton.bottomAnchor, leading: selectedImageView.trailingAnchor, trailing: nil, bottom: nil,padding: .init(top: 135, left: 35, bottom: 0, right: 0))
     languageDetails.anchor(top: selectedImageView.bottomAnchor, leading: view.layoutMarginsGuide.leadingAnchor, trailing: view.layoutMarginsGuide.trailingAnchor, bottom: view.layoutMarginsGuide.bottomAnchor,padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    
 }
 
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.languages.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectLanguageButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }

   @objc func onClickSelectLanguage() {
        addTransparentView(frames: selectLanguageButton.frame)
    }
   func configureTableView() {
     tableView.delegate = self
     tableView.dataSource = self
     tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
 }
    func configureCollectionView(){
        let myCollectionView:UICollectionView = UICollectionView()
               myCollectionView.dataSource = self
               myCollectionView.delegate = self
               myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
               myCollectionView.backgroundColor = UIColor.white
        NSLayoutConstraint.activate([
                myCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                myCollectionView.heightAnchor.constraint(equalToConstant: 150)
               ])
               self.view.addSubview(myCollectionView)
    }
    }

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = languages[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectLanguageButton.setTitle(languages[indexPath.row].name, for: .normal)
        selectLanguageButton.setImage(UIImage(named: languages[indexPath.row].name ?? "N/A"), for: .normal)
        selectedLanguageLabel.text = languages[indexPath.row].name
        selectedImageView.image = UIImage(named: languages[indexPath.row].name ?? "N/A")
        languages[indexPath.row].frameworks = collectionViewDataSource

        removeTransparentView()
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        cell.contentView.backgroundColor = .systemBlue
        return cell
    }
    
    
}

extension UIView {
    func anchor (top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
        topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
        leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
        trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if let bottom = bottom{
        bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}


