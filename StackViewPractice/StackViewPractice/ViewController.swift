//
//  ViewController.swift
//  StackViewPractice
//
//  Created by Nasraddin Rustamov on 9/1/21.
//

import UIKit

class ViewController: UIViewController {
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let apiCall = ApiCall()
    var myView = [MyView]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = .black
        apiCall.performRequest(completionHandler: { data in
                self.myView = data
            self.configureView()
            })
        configureScrollView()
        configureStackView()
    }
   
    fileprivate func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    fileprivate func configureView() {
        for index in 0..<(myView.count){
            let button = UIButton()
            let textView = UITextView()
            let imageView = UIImageView()
            
            textView.text = myView[index].text
            textView.font = UIFont.boldSystemFont(ofSize: 20)
            textView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            textView.backgroundColor = .white
            textView.textColor = .black
            
            button.backgroundColor = .red
            button.setTitle(myView[index].button, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            button.layer.cornerRadius = 10
            button.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
            //imageView.downloaded(from: myView[index].image ?? "")
            imageView.downloaded(from: "https://via.placeholder.com/600/b0f7cc")
            
            if myView[index].button != nil {
                stackView.addArrangedSubview(button)
            }
            
            if myView[index].text != nil {
                stackView.addArrangedSubview(textView)
            }
            if myView[index].image != nil {
                if myView[index].image != "" {
                    stackView.addArrangedSubview(imageView)
                }
            }
        }
    }
    
    fileprivate func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 20
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
    }

}
